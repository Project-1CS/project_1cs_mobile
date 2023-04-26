import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startease/Themes/colors.dart';
import 'package:startease/controller/create_role_controller.dart';
import 'package:get/get.dart';
import 'package:startease/view/widgets.dart';

class CreateRole extends StatelessWidget {
  const CreateRole({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final CreateRoleController createRoleController = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // title: Text("createRole".tr),
        leading: const BackIconButton(),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: GetBuilder<CreateRoleController>(builder: (context) {
                return Container(
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var step in createRoleController.steps)
                            Icon(
                              Icons.circle,
                              color: step <=
                                      createRoleController.currentStepIndex + 1
                                  ? purpleColor
                                  : Colors.grey,
                              size: step <=
                                      createRoleController.currentStepIndex + 1
                                  ? 24.0
                                  : 16.0,
                            )
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: screenHeight - 100,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: createRoleController.pageController,
                onPageChanged: (value) {
                  createRoleController.changeStepCurrentIndex(value);
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleMediumText(text: "createRole".tr),
                      SizedBox(
                        height: 10,
                      ),
                      SmallBodyText(text: "createRole1".tr),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            createRoleController.start();
                          },
                          child: Text("createRole2".tr))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TitleMediumText(text: "createRole3".tr),
                      SizedBox(
                        height: 10,
                      ),
                      SmallBodyText(text: "createRole4".tr),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: createRoleController.roleNameFormKey,
                        child: TextFormField(
                          decoration:
                              InputDecoration(hintText: "createRole9".tr),
                          onChanged: (value) {
                            createRoleController.roleNameInput(value);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enterRoleName".tr;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            if (createRoleController
                                .roleNameFormKey.currentState!
                                .validate()) {
                              createRoleController.roleNameFormKey.currentState!
                                  .save();
                              createRoleController.next();
                            }
                          },
                          child: Text("createRole5".tr))
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          TitleMediumText(text: "createRole6".tr),
                          SizedBox(
                            height: 10,
                          ),
                          SmallBodyText(text: "createRole7".tr),
                          SizedBox(
                            height: 10,
                          ),
                          GetBuilder<CreateRoleController>(builder: (context) {
                            return Container(
                              height: screenHeight - 350,
                              child: createRoleController
                                      .permissionsList.isNotEmpty
                                  ? ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 5,
                                        );
                                      },
                                      itemCount: createRoleController
                                          .permissionsList.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(createRoleController
                                                .permissionsList[index].name
                                                .toString()),
                                            CupertinoSwitch(
                                              value: createRoleController
                                                  .permissionsList[index].value,
                                              onChanged: ((value) {
                                                createRoleController
                                                    .changePermissionValue(
                                                        index, value);
                                              }),
                                              thumbColor: createRoleController
                                                      .permissionsList[index]
                                                      .value
                                                  ? purpleColor
                                                  : greyColor,
                                              activeColor:
                                                  purpleColor.withOpacity(0.5),
                                            )
                                          ],
                                        );
                                      })
                                  : Center(child: Text("is empty ")),
                            );
                          }),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            createRoleController.submit();
                          },
                          child: Text("createRole8".tr))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}