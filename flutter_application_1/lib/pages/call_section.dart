import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter_application_1/services/call.dart';

class CallWidget extends StatefulWidget {
  final String callId;
  final String userId;
  final String userType;
  final String userName;

  const CallWidget({
    super.key,
    required this.callId,
    required this.userId,
    required this.userType,
    required this.userName,
  });

  @override
  State<CallWidget> createState() => _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget> {
  final CallApi _callApi = CallApi();
  
  // State variables
  bool _isConnected = false;
  bool _sessionStarted = false;
  bool _callEnded = false;
  bool _isMuted = false;
  bool _isVideoOn = false;
  bool _hasMediaError = false;
  String _mediaErrorMessage = '';
  Map<String, dynamic> _participants = {};
  
  // Video elements
  html.VideoElement? _localVideoElement;
  final Map<String, html.VideoElement> _remoteVideoElements = {};
  
  @override
  void initState() {
    super.initState();
    _initializeCall();
  }

  void _initializeCall() {
    // Setup callbacks
    _callApi.onSessionStarted(() {
      print("sessionStarted : $mounted");
      if (mounted) {
        setState(() {
          _sessionStarted = true;
        });
      }
    });

    _callApi.onCallEnded(() {
      if (mounted) {
        setState(() {
          _callEnded = true;
        });
      }
    });

    _callApi.onParticipantsUpdate((participants) {
      if (mounted) {
        setState(() {
          _participants = participants;
        });
      }
    });

    _callApi.onRemoteStream((peerId, stream) {
      _addRemoteVideo(peerId, stream);
    });

    // Connect and join call
    _callApi.connect();
    _connectToCall();
  }

  Future<void> _connectToCall() async {
    try {
      await _callApi.joinCall(
        widget.callId,
        widget.userId,
        widget.userType,
        widget.userName,
      );
      
      if (mounted) {
        setState(() {
          _isConnected = true;
          _isMuted = _callApi.isMuted;
          _isVideoOn = _callApi.isVideoOn;
        });
        
        if (_callApi.localStream != null) {
          _setupLocalVideo();
        } else {
          // No local stream, show camera unavailable message
          setState(() {
            _hasMediaError = true;
            _mediaErrorMessage = 'Camera is being used by another app. Audio-only mode.';
          });
        }
      }
    } catch (e) {
      print('Error connecting to call: $e');
      if (mounted) {
        setState(() {
          _hasMediaError = true;
          _mediaErrorMessage = 'Failed to access camera/microphone. Please close other apps using the camera.';
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera access failed: Please close your mobile app or other apps using the camera'),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void _setupLocalVideo() {
    if (_callApi.localStream != null) {
      _localVideoElement = html.VideoElement()
        ..srcObject = _callApi.localStream
        ..autoplay = true
        ..muted = true
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover';

      // Register the video element
      ui.platformViewRegistry.registerViewFactory(
        'local-video-${widget.userId}',
        (int viewId) => _localVideoElement!,
      );

      if (mounted) {
        setState(() {});
      }
    }
  }

  void _addRemoteVideo(String peerId, html.MediaStream stream) {
    final videoElement = html.VideoElement()
      ..srcObject = stream
      ..autoplay = true
      ..muted = false
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover';

    _remoteVideoElements[peerId] = videoElement;

    // Register the video element
    ui.platformViewRegistry.registerViewFactory(
      'remote-video-$peerId',
      (int viewId) => videoElement,
    );

    if (mounted) {
      setState(() {});
    }
  }

  void _toggleMute() {
    _callApi.toggleMute();
    setState(() {
      _isMuted = _callApi.isMuted;
    });
  }

  void _toggleVideo() {
    _callApi.toggleVideo();
    setState(() {
      _isVideoOn = _callApi.isVideoOn;
    });
  }

  void _leaveCall() {
    _callApi.leaveCall();
    Navigator.pop(context);
  }

  void _endCall() {
    _callApi.endCall();
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
    Color? activeColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: isActive ? (activeColor ?? Colors.red) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              icon,
              color: isActive ? Colors.white : Colors.black54,
              size: 24,
            ),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantTile(String userId, Map<String, dynamic> participant) {
    final bool isCurrentUser = userId == widget.userId;
    final String name = participant['userName'] ?? 'Unknown';
    final bool isMuted = participant['muted'] ?? false;
    final bool hasVideo = participant['videoOn'] ?? false;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: isCurrentUser ? Border.all(color: Colors.blue, width: 2) : null,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: hasVideo
                  ? (isCurrentUser && _localVideoElement != null)
                      ? HtmlElementView(viewType: 'local-video-${widget.userId}')
                      : _remoteVideoElements.containsKey(userId)
                          ? HtmlElementView(viewType: 'remote-video-$userId')
                          : const Center(
                              child: Icon(Icons.videocam_off, size: 48, color: Colors.grey),
                            )
                  : Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : 'U',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    isCurrentUser ? 'You' : name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isMuted)
                  const Icon(
                    Icons.mic_off,
                    size: 16,
                    color: Colors.red,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_callEnded) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.call_end, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'Call Ended',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The call has been ended by the host.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (!_isConnected) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Connecting to call...'),
          ],
        ),
      );
    }

    if (!_sessionStarted) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Waiting for Session to Start',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please wait for the doctor to start the session.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  else{

    return Column(
      children: [
        // Call header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Call in Progress',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_participants.length} participant${_participants.length != 1 ? 's' : ''}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        
        // Video grid
        Expanded(
          child: Column(
            children: [
              // Show media error message if present
              if (_hasMediaError)
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange[700], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _mediaErrorMessage,
                          style: TextStyle(
                            color: Colors.orange[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Participants grid
              Expanded(
                child: _participants.isEmpty
                    ? const Center(child: Text('No participants'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _participants.length == 1 ? 1 : 2,
                          childAspectRatio: 4 / 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: _participants.length,
                        itemBuilder: (context, index) {
                          final entry = _participants.entries.elementAt(index);
                          return _buildParticipantTile(entry.key, entry.value);
                        },
                      ),
              ),
            ],
          ),
        ),
        
        // Control buttons
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                icon: _isMuted ? Icons.mic_off : Icons.mic,
                label: _isMuted ? 'Unmute' : 'Mute',
                onPressed: _toggleMute,
                isActive: _isMuted,
                activeColor: Colors.red,
              ),
              _buildControlButton(
                icon: _isVideoOn ? Icons.videocam : Icons.videocam_off,
                label: _isVideoOn ? 'Stop Video' : 'Start Video',
                onPressed: _toggleVideo,
                isActive: _isVideoOn,
                activeColor: Colors.green,
              ),
              _buildControlButton(
                icon: Icons.call_end,
                label: 'Leave',
                onPressed: _leaveCall,
                isActive: true,
                activeColor: Colors.red,
              ),
              if (widget.userType == 'doctor' || widget.userType == 'life_coach' || widget.userType == 'emergency_team')
                _buildControlButton(
                  icon: Icons.stop,
                  label: 'End Call',
                  onPressed: _endCall,
                  isActive: true,
                  activeColor: Colors.red[800],
                ),
            ],
          ),
        ),
      ],
    );
  }
  }

  @override
  void dispose() {
    _callApi.disconnect();
    
    // Clean up video elements
    _localVideoElement = null;
    _remoteVideoElements.clear();
    
    super.dispose();
  }
}