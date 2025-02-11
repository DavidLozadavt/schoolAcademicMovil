import 'package:flutter/material.dart';

class CardChats extends StatelessWidget {
  final String urlPhotoSender;
  final String name;
  final String lastName;
  final String endMessage;
  final String status; 

  const CardChats({
    required this.urlPhotoSender,
    required this.name,
    required this.endMessage,
    required this.lastName,
    required this.status,
    super.key,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'EN LINEA':
        return Colors.green;
      case 'OCUPADO':
        return Colors.orange;
      case 'NO DISPONIBLE':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                          urlPhotoSender,
                          fit: BoxFit.cover,
                          width: 56,
                          height: 56,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                              width: 56,
                              height: 56,
                            );
                          },
                        ),
                      ),
                    ),
                    if(status.isNotEmpty)Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getStatusColor(status),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name $lastName',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        endMessage,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
