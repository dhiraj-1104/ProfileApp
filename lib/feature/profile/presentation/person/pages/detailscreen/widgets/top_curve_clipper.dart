import 'package:flutter/material.dart';

class CustomNotch extends CustomClipper<Path> {
  final double cornerRadius; // Radius for the bottom corners
  final double handleWidth;    // Width of the flat top handle/tab
  final double handleHeight;   // Height/depth of the handle/tab cutout
  final double sideSlopeHeight; // How much the top-left/right sides slope down before meeting the handle

  CustomNotch({
    this.cornerRadius = 30.0,
    this.handleWidth = 60.0,
    this.handleHeight = 14.0,
    this.sideSlopeHeight = 15.0, // Adjust this for the slope's depth
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    // Ensure values are within bounds
    final actualCornerRadius = cornerRadius.clamp(0.0, size.width / 2);
    final actualHandleWidth = handleWidth.clamp(0.0, size.width - (2 * actualCornerRadius));
    final halfHandleWidth = actualHandleWidth / 2;

    // Calculate handle start/end X coordinates
    final center = size.width / 2;
    final handleStartX = center - halfHandleWidth;
    final handleEndX = center + halfHandleWidth;

    // --- Start Drawing ---

    // 1. Move to the top-left start point (after implied flat top before curve)
    path.moveTo(0, sideSlopeHeight + handleHeight); // Start low enough for the slope

    // 2. Draw the bottom-left rounded corner (bottom corners are usually rounded in such designs)
    // For this specific image, it seems the rounded corners are only on the top-left and top-right *outer* edge.
    // Let's re-evaluate based on the image: the image shows rounded top-left and top-right of the **entire shape**.

    // Let's assume the rounded corners are on the main body of the container, at the top.
    // The handle is a cutout.

    // Start drawing from the point after the top-left outer rounded corner
    path.moveTo(0, actualCornerRadius);

    // Top-left outer rounded corner
    path.arcToPoint(
      Offset(actualCornerRadius, 0),
      radius: Radius.circular(actualCornerRadius),
      clockwise: true,
    );

    // Line from top-left rounded corner to the start of the left slope of the cutout
    path.lineTo(handleStartX - actualCornerRadius, 0); // Flat top segment before slope

    // Left slope down to the handle start
    path.lineTo(handleStartX, handleHeight);

    // Flat top of the handle cutout
    path.lineTo(handleEndX, handleHeight);

    // Right slope up from the handle end
    path.lineTo(handleEndX + actualCornerRadius, 0); // The top-right end of the slope

    // Line from the end of the right slope to the start of the top-right outer rounded corner
    path.lineTo(size.width - actualCornerRadius, 0);

    // Top-right outer rounded corner
    path.arcToPoint(
      Offset(size.width, actualCornerRadius),
      radius: Radius.circular(actualCornerRadius),
      clockwise: true,
    );

    // Draw down the right side
    path.lineTo(size.width, size.height);

    // Draw across the bottom
    path.lineTo(0, size.height);

    // Close the path (draws up the left side)
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}