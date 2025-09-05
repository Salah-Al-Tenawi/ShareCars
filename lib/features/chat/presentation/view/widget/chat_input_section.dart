import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputSection extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSendText;
  final Function(XFile image, String caption) onSendImage;

  const ChatInputSection({
    Key? key,
    required this.controller,
    required this.onSendText,
    required this.onSendImage,
  }) : super(key: key);

  @override
  State<ChatInputSection> createState() => _ChatInputSectionState();
}

class _ChatInputSectionState extends State<ChatInputSection> {
  final ImagePicker _picker = ImagePicker();
  bool _isSendingImage = false;
  XFile? _pickedImage;
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = picked;
        _isSendingImage = true;
      });
      _showImagePreviewDialog();
    }
  }

  void _showImagePreviewDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Send Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_pickedImage != null)
                Image.file(
                  File(_pickedImage!.path),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  hintText: 'Add a caption (optional)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _captionController.clear();
                setState(() {
                  _pickedImage = null;
                  _isSendingImage = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_pickedImage != null) {
                  widget.onSendImage(_pickedImage!, _captionController.text);
                  _captionController.clear();
                  setState(() {
                    _pickedImage = null;
                    _isSendingImage = false;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: _pickImage,
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => widget.onSendText(),
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: widget.onSendText,
          ),
        ],
      ),
    );
  }
}
