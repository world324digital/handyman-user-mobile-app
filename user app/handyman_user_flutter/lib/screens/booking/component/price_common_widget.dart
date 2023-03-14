import 'package:booking_system_flutter/component/price_widget.dart';
import 'package:booking_system_flutter/main.dart';
import 'package:booking_system_flutter/model/booking_data_model.dart';
import 'package:booking_system_flutter/model/package_data_model.dart';
import 'package:booking_system_flutter/model/service_data_model.dart';
import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/utils/colors.dart';
import 'package:booking_system_flutter/utils/common.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:booking_system_flutter/utils/model_keys.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceCommonWidget extends StatelessWidget {
  final BookingData bookingDetail;
  final ServiceData serviceDetail;
  final List<TaxData> taxes;
  final CouponData? couponData;
  final BookingPackage? bookingPackage;

  const PriceCommonWidget({
    Key? key,
    required this.bookingDetail,
    required this.serviceDetail,
    required this.taxes,
    required this.couponData,
    required this.bookingPackage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (serviceDetail.isFreeService) return Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        Text(language.priceDetail, style: boldTextStyle(size: LABEL_TEXT_SIZE)),
        16.height,
        if (bookingPackage != null)
          Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            decoration: boxDecorationDefault(color: context.cardColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(language.totalAmount, style: secondaryTextStyle(size: 16)).expand(),
                    PriceWidget(price: bookingDetail.amount.validate(), color: primaryColor, size: 18),
                  ],
                ),
              ],
            ),
          )
        else
          Container(
            padding: EdgeInsets.all(16),
            width: context.width(),
            decoration: boxDecorationDefault(color: context.cardColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(language.lblPrice, style: secondaryTextStyle(size: 16)).expand(),
                    16.width,
                    PriceWidget(price: bookingDetail.amount.validate(), size: 18, color: textPrimaryColorGlobal, isBoldText: true),
                  ],
                ),
                if (!serviceDetail.isHourlyService)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(language.lblSubTotal, style: secondaryTextStyle(size: 16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${appStore.currencySymbol}${bookingDetail.amount.validate().toStringAsFixed(DECIMAL_POINT)} * ${bookingDetail.quantity != 0 ? bookingDetail.quantity : 1}',
                                style: secondaryTextStyle(size: 14),
                                textAlign: TextAlign.right,
                              ).flexible(),
                              4.width,
                              Text(
                                '${appStore.currencySymbol}${(bookingDetail.amount.validate() * (bookingDetail.quantity != 0 ? bookingDetail.quantity.validate() : 1)).toStringAsFixed(DECIMAL_POINT)}',
                                style: boldTextStyle(size: 18),
                                textAlign: TextAlign.right,
                              ).flexible(),
                            ],
                          ).expand(),
                        ],
                      ),
                    ],
                  ),
                if (serviceDetail.taxAmount.validate() != 0)
                  Column(
                    children: [
                      Divider(height: 26),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(language.lblTax, style: secondaryTextStyle(size: 16)),
                          16.width,
                          PriceWidget(price: serviceDetail.taxAmount!, size: 18, color: Colors.red, isBoldText: true),
                        ],
                      ),
                    ],
                  ),
                if (serviceDetail.discountPrice.validate() != 0)
                  Row(
                    children: [
                      Column(
                        children: [
                          Divider(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  Text(language.lblDiscount, style: secondaryTextStyle(size: 16)),
                                  Text(" (${serviceDetail.discount.validate()}% ${language.lblOff.toLowerCase()})", style: boldTextStyle(color: Colors.green)),
                                ],
                              ),
                              16.width,
                              PriceWidget(
                                price: serviceDetail.discountPrice.validate(),
                                size: 18,
                                color: Colors.green,
                                isBoldText: true,
                                isDiscountedPrice: true,
                              ),
                            ],
                          ),
                        ],
                      ).flexible(),
                    ],
                  ),
                if (couponData != null) Divider(height: 26),
                if (couponData != null)
                  Row(
                    children: [
                      Text(language.lblCoupon, style: secondaryTextStyle(size: 16)),
                      Text(" (${couponData!.code})", style: secondaryTextStyle(size: 16, color: primaryColor)).expand(),
                      PriceWidget(price: serviceDetail.couponDiscountAmount.validate(), size: 18, color: Colors.green, isBoldText: true, isDiscountedPrice: true),
                    ],
                  ),
                if (bookingDetail.extraCharges.validate().isNotEmpty) Divider(height: 26),
                if (bookingDetail.extraCharges.validate().isNotEmpty)
                  if (bookingDetail.extraCharges != null)
                    Row(
                      children: [
                        Text(language.lblTotalExtraCharges, style: secondaryTextStyle(size: 16)).expand(),
                        PriceWidget(price: bookingDetail.extraCharges.sumByDouble((e) => e.total.validate()), color: textPrimaryColorGlobal, size: 18),
                      ],
                    ),
                Divider(height: 26),
                Row(
                  children: [
                    Text(language.totalAmount, style: secondaryTextStyle(size: 16)).expand(),
                    if (bookingDetail.isHourlyService) Text('(${appStore.currencySymbol}${bookingDetail.price}/hr)  ', style: secondaryTextStyle()),
                    PriceWidget(price: getTotalValue, color: primaryColor, size: 18),
                  ],
                ),
                if (bookingDetail.isHourlyService && bookingDetail.status == BookingStatusKeys.complete)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      children: [
                        6.height,
                        Text(
                          "${language.lblOnBase} ${calculateTimer(bookingDetail.durationDiff.validate().toInt())} ${getMinHour(durationDiff: bookingDetail.durationDiff.validate())}",
                          style: secondaryTextStyle(),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
      ],
    );
  }

  num get getTotalValue {
    num totalAmount = calculateTotalAmount(
      serviceDiscountPercent: serviceDetail.discount.validate(),
      qty: bookingDetail.quantity.validate(value: 1).toInt(),
      detail: serviceDetail,
      servicePrice: bookingDetail.amount.validate(),
      taxes: taxes,
      couponData: couponData,
      extraCharges: bookingDetail.extraCharges.validate(),
    );

    if (bookingDetail.isHourlyService && bookingDetail.status == BookingStatusKeys.complete) {
      return calculateTotalAmount(
        serviceDiscountPercent: serviceDetail.discount.validate(),
        qty: bookingDetail.quantity.validate(value: 1).toInt(),
        detail: serviceDetail,
        servicePrice: getHourlyPrice(
          price: bookingDetail.amount.validate(),
          secTime: bookingDetail.durationDiff.validate().toInt(),
          date: bookingDetail.date.validate(),
        ),
        taxes: taxes,
        couponData: couponData,
        extraCharges: bookingDetail.extraCharges.validate(),
      );
    }

    return totalAmount;
  }

  String getMinHour({required String durationDiff}) {
    String totalTime = calculateTimer(durationDiff.toInt());
    List<String> totalHours = totalTime.split(":");
    if (totalHours.first == "00") {
      return "min";
    } else {
      return "hour";
    }
  }
}
