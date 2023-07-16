import 'package:capstone_project/features/explore/presentation/widgets/quiz_preview_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/domain/entity/quiz_preview.dart';

class HorizontalScrollList extends StatelessWidget {
  const HorizontalScrollList({super.key, required this.scrollController, required this.quizzes});

  final ScrollController scrollController;
  final List<QuizPreview> quizzes;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (QuizPreview quizPreview in quizzes) {
      widgets.add(QuizPreviewCardWidget(quizPreview: quizPreview));
    }
    return Scrollbar(
      trackVisibility: true,
      controller: scrollController,
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widgets,
        ),
      ),
    );
  }
}
