import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carplay/constants/private_constants.dart';
import 'package:flutter_carplay/controllers/carplay_controller.dart';
import 'package:flutter_carplay/flutter_carplay.dart';
import 'package:flutter_carplay/models/map/map_list.dart';
import 'package:flutter_carplay/models/map/map_list_header.dart';
import 'package:flutter_carplay/models/map/map_point.dart';
// ignore_for_file: avoid_print

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CPConnectionStatusTypes connectionStatus = CPConnectionStatusTypes.unknown;
  final FlutterCarplay _flutterCarplay = FlutterCarplay();

  String voiceControlTranscript = '';
  late CPMapTemplate cpMapTemplate;

  /// true = voice control recording started and listening, false = not recording
  bool voiceControlStatus = false;

  @override
  void initState() {
    super.initState();
    // initialCarPlay();
    _openMapTemplate();
    _flutterCarplay
      ..forceUpdateRootTemplate()
      ..addListenerOnConnectionChange(onCarplayConnectionChange);
  }

  void initialCarPlay() {
    FlutterCarplay.setRootTemplate(
      rootTemplate: CPTabBarTemplate(
        templates: [
          _itemTabBarHouse(),
        ],
      ),
    );

    _flutterCarplay.forceUpdateRootTemplate();
  }

  CPListTemplate _itemTabBarHouse() {
    return CPListTemplate(
      sections: [
        CPListSection(
          items: [
            CPListItem(
              text: 'Map',
              onPressed: (complete, self) {
                _openMapTemplate();
                // self.
                complete();
              },
            ),
          ],
          header: 'Trip',
        ),
      ],
      systemIcon: 'house.fill',
      emptyViewSubtitleVariants: [
        'Please login to use application',
      ],
    );
  }

  _openMapTemplate() {
    cpMapTemplate = CPMapTemplate(
      title: 'Map Template',
      mapButtons: [
        CPMapButton(
          onPressed: _moveCamera,
          image: 'images/logo_flutter_1080px_clr.png',
        ),
        CPMapButton(
          onPressed: _centerMap,
          image: 'images/logo_flutter_1080px_clr.png',
        ),
        CPMapButton(
          onPressed: _zoomIn,
          image: 'images/logo_flutter_1080px_clr.png',
        ),
        CPMapButton(
          onPressed: _zoomOut,
          image: 'images/logo_flutter_1080px_clr.png',
        ),
      ],
      leadingNavigationBarButtons: [
        CPBarButton(
          // title: 'Up',
          image: 'images/up1.png',
          style: CPBarButtonStyles.none,
          onPressed: () async {
            cpMapTemplate.scrollUpMapList();
          },
        ),
        CPBarButton(
          // title: 'Down',
          image: 'images/donw1.png',
          style: CPBarButtonStyles.none,
          onPressed: () async {
            cpMapTemplate.scrollDownMapList();
          },
        ),
      ],
      trailingNavigationBarButtons: [
        CPBarButton(
          title: 'Close',
          // image: 'images/logo_flutter_1080px_clr.png',
          onPressed: () {
            cpMapTemplate.dismissPanningInterface();
          },
        ),
        CPBarButton(
          title: 'Settings',
          onPressed: () async {
            final didPush = await FlutterCarplay.push(
              template: CPListTemplate(
                sections: [],
                title: 'Settings',
                emptyViewTitleVariants: ['Settings'],
                emptyViewSubtitleVariants: [
                  'No settings have been added here yet. You can start adding right away',
                ],
                systemIcon: 'gear',
              ),
            );
            if (didPush) log('Opened Settings');
          },
        ),
      ],
      dashboardButtons: [
        CPDashboardButton(
          onPressed: () {},
          image: 'mages/logo_flutter_1080px_clr.png',
        ),
      ],
      automaticallyHidesNavigationBar: true,
    );

    FlutterCarplay.setRootTemplate(rootTemplate: cpMapTemplate);
    _addMapList();
    _addPolyline();
    _addMarker();
  }

  _zoomIn() {
    cpMapTemplate.zoomInMapView();
  }

  _zoomOut() {
    cpMapTemplate.zoomOutMapView();
  }

  _moveCamera() {
    cpMapTemplate.showPanningInterface();
  }

  _centerMap() {
    cpMapTemplate.centerMapView();
    final data = <CPMapList>[
      CPMapList(
        address: 'Ben xe mien dong 111111',
        time: '15:00',
        isCheckIn: true,
        isCurrentPoint: true,
        isShowUserPick: true,
        userPick: '20/20',
        isShowUserDrop: true,
        userDrop: '2/2',
        isShowLabelUserConfirm: true,
        confirmUser: 'Confirm',
      ),
      CPMapList(
        address: 'Ben xe mien bac',
        time: '17:00',
        isShowUserPick: true,
        userPick: '70/70',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe mien tay',
        time: '17:00',
        isShowUserPick: true,
        userPick: '42/42',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe suoi tien',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe da nang',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe quang  ngai',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe quang nam',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe suoi tien',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address:
            '55/9 Đ. Lý Chiêu Hoàng, Khu II, Quận 6, Thành phố Hồ Chí Minh 700000, Việt Nam',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address:
            '163-75 Song Hành, Phường 10, Quận 6, Thành phố Hồ Chí Minh 747160, Việt Nam',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
    ];
    cpMapTemplate.updateMapList(data: data);
  }

  _addMapList() {
    final data = <CPMapList>[
      CPMapList(
        address: 'Ben xe mien dong',
        time: '15:00',
        isCheckIn: true,
        isCurrentPoint: true,
        isShowUserPick: true,
        userPick: '20/20',
        isShowUserDrop: true,
        userDrop: '2/2',
        isShowLabelUserConfirm: true,
        confirmUser: 'Confirm',
        estimateTime: '15:22',
        lateEstimateTimeLate: true,
      ),
      CPMapList(
        address: 'Ben xe mien bac',
        time: '17:00',
        isShowUserPick: true,
        userPick: '70/70',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe mien tay',
        time: '17:00',
        isShowUserPick: true,
        userPick: '42/42',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe suoi tien',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe da nang',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe quang  ngai',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe quang nam',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe suoi tien',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'Ben xe D',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
      CPMapList(
        address: 'ben xe z',
        time: '17:00',
        isShowUserPick: true,
        userPick: '1',
        isShowUserDrop: true,
        userDrop: '5',
      ),
    ];

    final dataEstimatePoint = CPMapListHeader(
      time: '1h30p',
      titleTime: '11:00',
      distance: '250 km',
      title: 'Vị trí hiện tại',
    );
    cpMapTemplate.addMapList(data: data, dataEstimatePoint: dataEstimatePoint);
  }

  _addPolyline() {
    final data = <CPMapPoint>[
      CPMapPoint(
        lat: 10.804334,
        lng: 106.721583,
      ),
      CPMapPoint(
        lat: 10.815884,
        lng: 106.710815,
      ),
    ];
    cpMapTemplate.addPolyline(data: data);

    final dataUser = <CPMapPoint>[
      CPMapPoint(
        lat: 10.815884,
        lng: 106.710815,
      ),
      CPMapPoint(
        lat: 10.864870,
        lng: 106.724350,
      ),
    ];
    cpMapTemplate.addPolyline(data: dataUser, colorUser: true);
  }

  _addMarker() {
    final data = <CPMapPoint>[
      CPMapPoint(
        lat: 10.815884,
        lng: 106.710815,
        title: '12',
        subTitle: 'marker_job',
      ),
      CPMapPoint(
        lat: 10.864870,
        lng: 106.724350,
        title: '4',
        subTitle: 'marker_job_check_in',
      ),
      CPMapPoint(
        lat: 10.75902280455639,
        lng: 106.67528882698097,
        title: '2',
        subTitle: 'marker_job',
      ),
    ];
    cpMapTemplate.addMarker(data: data);
  }

  @override
  void dispose() {
    _flutterCarplay.removeListenerOnConnectionChange();
    super.dispose();
  }

  void onCarplayConnectionChange(CPConnectionStatusTypes status) {
    // Do things when carplay state is connected, background or disconnected
    setState(() => connectionStatus = status);
  }

  void showAlert() {
    FlutterCarplay.showAlert(
      template: CPAlertTemplate(
        titleVariants: ['Alert Title'],
        actions: [
          CPAlertAction(
            title: 'Okay',
            onPressed: () {
              FlutterCarplay.popModal();
              print('Okay pressed');
            },
          ),
          CPAlertAction(
            title: 'Cancel',
            style: CPAlertActionStyles.cancel,
            onPressed: () {
              FlutterCarplay.popModal();
              print('Cancel pressed');
            },
          ),
          CPAlertAction(
            title: 'Remove',
            style: CPAlertActionStyles.destructive,
            onPressed: () {
              FlutterCarplay.popModal();
              print('Remove pressed');
            },
          ),
        ],
      ),
    );
  }

  void showActionSheet() {
    FlutterCarplay.showActionSheet(
      template: CPActionSheetTemplate(
        title: 'Action Sheet Template',
        message: 'This is an example message.',
        actions: [
          CPAlertAction(
            title: 'Cancel',
            style: CPAlertActionStyles.cancel,
            onPressed: () {
              print('Cancel pressed in action sheet');
              FlutterCarplay.popModal();
            },
          ),
          CPAlertAction(
            title: 'Dismiss',
            style: CPAlertActionStyles.destructive,
            onPressed: () {
              print('Dismiss pressed in action sheet');
              FlutterCarplay.popModal();
            },
          ),
          CPAlertAction(
            title: 'Ok',
            onPressed: () {
              print('Ok pressed in action sheet');
              FlutterCarplay.popModal();
            },
          ),
        ],
      ),
    );
  }

  void addNewTemplate(CPListTemplate newTemplate) {
    final currentRootTemplate = FlutterCarplay.rootTemplate!;

    currentRootTemplate.templates.add(newTemplate);

    FlutterCarplay.setRootTemplate(
      rootTemplate: currentRootTemplate,
    );
    _flutterCarplay.forceUpdateRootTemplate();
  }

  void removeLastTemplate() {
    final currentRootTemplate = FlutterCarplay.rootTemplate!;

    currentRootTemplate.templates.remove(currentRootTemplate.templates.last);

    FlutterCarplay.setRootTemplate(
      rootTemplate: currentRootTemplate,
    );
    _flutterCarplay.forceUpdateRootTemplate();
  }

  void openSearchTemplate() {
    FlutterCarplay.push(
      template: CPSearchTemplate(
        onSearchTextUpdated: (query, searchComplete) {
          searchComplete([
            CPListItem(
              text: query,
              onPressed: (complete, item) {
                log('Search item: ${item.text} selected');
                FlutterCarplay.pop();
              },
            ),
          ]);
        },
      ),
    );
  }

  void openGridTemplate() {
    FlutterCarplay.push(
      template: CPGridTemplate(
        title: 'Grid Template',
        buttons: [
          for (var i = 1; i < 9; i++)
            CPGridButton(
              titleVariants: ['Item $i'],
              // ----- TRADEMARKS RIGHTS INFORMATION BEGIN -----
              // The official Flutter logo is used from the link below.
              // For more information, please visit and read
              // Flutter Brand Guidelines Website: https://flutter.dev/brand
              //
              // FLUTTER AND THE RELATED LOGO ARE TRADEMARKS OF Google LLC.
              // WE ARE NOT ENDORSED BY OR AFFILIATED WITH Google LLC.
              // ----- TRADEMARKS RIGHTS INFORMATION END -----
              image: 'images/logo_flutter_1080px_clr.png',
              onPressed: () {
                print('Grid Button $i pressed');
              },
            ),
        ],
      ),
    );
  }

  void openListTemplate() {
    FlutterCarplay.push(
      template: CPListTemplate(
        sections: [
          CPListSection(
            header: 'A Section',
            items: [
              CPListItem(
                text: 'Item 1',
                onPressed: (onCompleted, item) {
                  log('Item 1 clicked');
                  item.update(isEnabled: false);
                  onCompleted();
                },
              ),
              CPListItem(
                text: 'Item 2',
                onPressed: (onCompleted, item) {
                  log('Item 2 clicked');
                  item.update(text: 'ABC', detailText: 'New ABC');
                  onCompleted();
                },
              ),
              CPListItem(
                text: 'Item 3',
                onPressed: (onCompleted, item) {
                  log('Item 2 clicked');
                  openListTemplate();
                  onCompleted();
                },
              ),
              CPListItem(text: 'Item 4'),
            ],
          ),
          CPListSection(
            header: 'B Section',
            items: [
              CPListItem(text: 'Item 5'),
              CPListItem(text: 'Item 6'),
            ],
          ),
          CPListSection(
            header: 'C Section',
            items: [
              CPListItem(text: 'Item 7'),
              CPListItem(text: 'Item 8'),
            ],
          ),
        ],
        systemIcon: 'systemIcon',
        title: 'List Template',
        backButton: CPBarButton(
          title: 'Back',
          onPressed: () {
            log('back button call back received');
            FlutterCarplay.pop();
          },
          style: CPBarButtonStyles.none,
        ),
      ),
    );
  }

  void openInformationTemplate() {
    FlutterCarplay.push(
      template: CPInformationTemplate(
        title: 'Title',
        layout: CPInformationTemplateLayout.twoColumn,
        actions: [
          CPTextButton(
            title: 'Button Title 1',
            onPressed: () {
              print('Button 1');
            },
          ),
          CPTextButton(
            title: 'Button Title 2',
            onPressed: () {
              print('Button 2');
            },
          ),
        ],
        informationItems: [
          CPInformationItem(title: 'Item title 1', detail: 'detail 1'),
          CPInformationItem(title: 'Item title 2', detail: 'detail 2'),
          CPInformationItem(title: 'Item title 3', detail: 'detail 3'),
          CPInformationItem(title: 'Item title 4', detail: 'detail 4'),
          CPInformationItem(title: 'Item title 5', detail: 'detail 5'),
          CPInformationItem(title: 'Item title 6', detail: 'detail 6'),
          CPInformationItem(title: 'Item title 7', detail: 'detail 7'),
          CPInformationItem(title: 'Item title 8', detail: 'detail 8'),
          CPInformationItem(title: 'Item title 9', detail: 'detail 9'),
          CPInformationItem(title: 'Item title 10', detail: 'detail 10'),
        ],
      ),
    );
  }

  void openPoiTemplate() {
    FlutterCarplay.push(
      template: CPPointOfInterestTemplate(
        title: 'Title',
        poi: [
          CPPointOfInterest(
            latitude: 51.5052,
            longitude: 7.4938,
            title: 'Title',
            subtitle: 'Subtitle',
            summary: 'Summary',
            detailTitle: 'DetailTitle',
            detailSubtitle: 'detailSubtitle',
            detailSummary: 'detailSummary',
            image: 'images/logo_flutter_1080px_clr.png',
            primaryButton: CPTextButton(
              title: 'Primary',
              onPressed: () {
                print('Primary button pressed');
              },
            ),
            secondaryButton: CPTextButton(
              title: 'Secondary',
              onPressed: () {
                print('Secondary button pressed');
              },
            ),
          ),
        ],
      ),
    );
  }

  void showVoiceControl(BuildContext context) {
    /// Clearing previous transcript and sets the status as started.
    setState(() {
      voiceControlStatus = false;
      voiceControlTranscript = '';
    });

    /// Displaying voice control to CarPlay.
    FlutterCarplay.showVoiceControl(
      template: CPVoiceControlTemplate(
        voiceControlStates: [
          CPVoiceControlState(
            titleVariants: ['Example Voice Control'],
            image: 'images/ios_9.gif',
            identifier: 'test',
            repeats: true,
          ),
        ],
      ),
    );

    /// Greet the user with a localized speech from a text.
    FlutterCarplay.speak(
      CPSpeaker(
        text:
            'Welcome to voice control. To stop, you can say stop the voice control.',
      ),
    );

    /// [DISCLAIMER]
    /// THE DIALOG IS USED FOR EXAMPLE-ONLY IN ORDER TO
    /// INTRODUCE ALL ACTIONS OF THIS PACKAGE BETTER.
    /// YOU SHOULD NEVER SHOW ANY DIALOG OR ALERT TO
    /// ANY USER'S OR ESPECIALLY ANY DRIVER'S PHONE.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Voice Control System'),
          actions: [
            StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (voiceControlStatus == false)
                      const Text(
                        'You can start or stop voice control anytime. Currently, voice control is not listening you.',
                        textAlign: TextAlign.center,
                      )
                    else
                      const Text(
                        'Voice control is listening, you can start talking. It will be shown below.',
                        textAlign: TextAlign.center,
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: voiceControlTranscript != ''
                          ? Text('Transcript: $voiceControlTranscript')
                          : const SizedBox(),
                    ),
                    if (voiceControlStatus == false)
                      TextButton(
                        onPressed: () => startVoiceControl(setState),
                        child: const Text('Start Recording'),
                      )
                    else
                      TextButton(
                        onPressed: () => endVoiceControl(setState),
                        child: const Text('Stop Recording'),
                      ),
                    TextButton(
                      onPressed: () {
                        if (voiceControlStatus == true) {
                          setState(() {
                            voiceControlStatus = false;
                          });
                          FlutterCarplay.stopVoiceControl();
                          FlutterCarplay
                              .removeListenerOnSpeechRecognitionTranscriptChange();
                        }
                        setState(() {
                          voiceControlTranscript = '';
                        });
                        Navigator.of(context).pop();
                        FlutterCarplay.speak(
                          CPSpeaker(
                            text: 'Voice control is stopping.',
                            onCompleted: FlutterCarplay.popModal,
                          ),
                        );
                      },
                      child: const Text('Close Voice Control'),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  void startVoiceControl(void Function(VoidCallback) setState) {
    if (voiceControlStatus == false) {
      /// Play a sound to signal the user to begin speaking
      FlutterCarplay.play(
        CPAudio(
          soundPath: 'musics/ping_sound_effect.mp3',
        ),
      );
      FlutterCarplay.startVoiceControl();
      setState(() {
        voiceControlStatus = true;
        voiceControlTranscript = '';
      });
      FlutterCarplay.addListenerOnSpeechRecognitionTranscriptChange(
        onSpeechRecognitionTranscriptChange: (transcript) {
          log('Transcript: $transcript');
          setState(() => voiceControlTranscript = transcript);
          checkVoiceControlTranscript(
            transcript: transcript,
            inModal: true,
          );
        },
      );
    }
  }

  void endVoiceControl(void Function(VoidCallback) setState) {
    if (voiceControlStatus == true) {
      FlutterCarplay.speak(
        CPSpeaker(
          text: 'You said that, $voiceControlTranscript',
        ),
      );
      setState(() {
        voiceControlStatus = false;
      });
      FlutterCarplay.stopVoiceControl();
      FlutterCarplay.removeListenerOnSpeechRecognitionTranscriptChange();
    }
  }

  void checkVoiceControlTranscript({
    required String transcript,
    bool inModal = false,
  }) {
    if (transcript.toUpperCase().contains('STOP THE VOICE CONTROL')) {
      setState(() {
        voiceControlStatus = false;
        voiceControlTranscript = '';
      });
      FlutterCarplay.stopVoiceControl();
      FlutterCarplay.removeListenerOnSpeechRecognitionTranscriptChange();
      FlutterCarplay.speak(
        CPSpeaker(
          text: 'Okay, voice control is stopping.',
          onCompleted: FlutterCarplay.popModal,
        ),
      );
      if (inModal) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Carplay'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: () => addNewTemplate(
                  CPListTemplate(
                    sections: [],
                    title: 'Blank Screen',
                    emptyViewTitleVariants: ['Blank Screen Example'],
                    emptyViewSubtitleVariants: [
                      "You've just added a blank screen to carplay from your iphone.",
                    ],
                    showsTabBadge: true,
                    systemIcon: 'airpods',
                  ),
                ),
                child: const Text(
                  'Add blank\nscreen',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 20, height: 0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: removeLastTemplate,
                child: const Text(
                  'Remove last\nscreen',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Center(child: Text('Carplay Status: ${connectionStatus.name}')),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: showAlert,
                child: const Text('Alert'),
              ),
              const SizedBox(width: 15, height: 0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: showActionSheet,
                child: const Text('Action Sheet'),
              ),
              const SizedBox(width: 15, height: 0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: FlutterCarplay.popModal,
                child: const Text('Close Modal'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: FlutterCarplay.pop,
                child: const Text('Pop Screen'),
              ),
              const SizedBox(width: 20, height: 0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: FlutterCarplay.popToRoot,
                child: const Text('Pop To Root'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: openListTemplate,
                child: const Text('Open List\nTemplate'),
              ),
              const SizedBox(width: 20, height: 0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                ),
                onPressed: openGridTemplate,
                child: const Text('Open Grid\nTemplate'),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 15),
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 24,
              ),
            ),
            onPressed: _flutterCarplay.forceUpdateRootTemplate,
            child: const Text('Force Update Carplay'),
          ),
          const SizedBox(width: 50, height: 0),
        ],
      ),
    );
  }
}
