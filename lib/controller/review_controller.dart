// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vc/model/review/create_review_model.dart';
import 'package:vc/model/review/create_worker_review_model.dart';
import 'package:vc/services/review/add_review_service.dart';

import '../theme/constant/constants.dart';

class ReviewController extends GetxController {
  Future<ReviewModel?> addReview({
    required String comments,
    required String starRating,
    required String serviceId,
    required BuildContext context,
    required String url,
  }) async {
    final data = await AddReviewService().addReview(
      url: url,
      body: {
        'service_id': serviceId,
        'comments': comments,
        'star_rating': starRating,
      },
    );
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      return ReviewModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }

  Future<AddWorkerReviewModel?> addWorkerReview({
    required String comments,
    required String starRating,
    required String workerId,
    required BuildContext context,
    required String url,
  }) async {
    final data = await AddReviewService().addReview(
      url: url,
      body: {
        'worker_id': workerId,
        'comments': comments,
        'star_rating': starRating,
      },
    );
    if (data['statusCode'] != null && data['statusCode'] == 200) {
      return AddWorkerReviewModel.fromJson(data);
    } else {
      ShowBanner.showBanner(context: context, text: data['message']);
    }
    return null;
  }
}
