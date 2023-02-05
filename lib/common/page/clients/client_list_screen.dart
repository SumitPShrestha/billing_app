import 'package:billing_app/common/components/list_item_component.dart';
import 'package:billing_app/common/page/clients/add_client_screen.dart';
import 'package:billing_app/dto/client_dto.dart';
import 'package:flutter/material.dart';
import 'package:billing_app/common/page/dashboard_screeen.dart';
import 'package:billing_app/common/page/list_screen.dart';
import 'package:billing_app/services/client_service.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({Key? key}) : super(key: key);

  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  Future<List<ClientDTO>> clients = ClientService().getClients("", 50);

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return ListScreen(
      appBarTitle: "Client List",
      backButton: true,
      onPressedBackButton: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return const DashboardScreeen();
      })),
      mainComponent: FutureBuilder<List<ClientDTO>>(
          future: clients,
          builder: (context, AsyncSnapshot<List<ClientDTO>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int index) {
                        var clientToDisplay = snapshot.data![index].client;

                        return ListItemComponent(
                          headerText: clientToDisplay!.name,
                          subText1: clientToDisplay!.contact1,
                          onEditPressed: ()=>Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                                return AddClientScreen(clientDTO: ClientDTO(client: clientToDisplay),);
                              })),
                          onDeletePressed: () =>
                              ClientService().delete(clientToDisplay),
                          subText2: (clientToDisplay!.phone ?? "") +
                              ", " +
                              (clientToDisplay.billing_address1 ?? ""),
                        );
                      })
                  : const Center(
                      child: Text(
                      "No Data!!",
                      style: TextStyle(color: Colors.red, fontSize: 30),
                    ));
            } else if (snapshot.hasError) {
              return Center(
                  child: Container(
                child: Column(children: <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ]),
              ));
            } else {
              return Center(
                child: Container(
                  child: Column(
                    children: const <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
      onFloatingButtonPressed: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return AddClientScreen();
      })),
    );
  }
}
