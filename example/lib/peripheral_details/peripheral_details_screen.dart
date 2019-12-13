import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/components/peripheral_details_view.dart';
import 'package:blemulator_example/peripheral_details/peripheral_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeripheralDetailsBloc, PeripheralDetailsState>(
      builder: (context, state) {
        if (state is PeripheralAvailable) {
          return _buildPeripheralAvailableState(state);
        } else if (state is PeripheralUnavailable) {
          return _buildPeripheralUnavailableState(state);
        } else {
          return null;
        }
      },
    );
  }

  Widget _buildPeripheralAvailableState(PeripheralAvailable state) {
    if (state.peripheralInfo.peripheralLayout ==
        PeripheralLayout.tabbed) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: _buildAppBarTitle(state.peripheralInfo.name),
            bottom: TabBar(tabs: [
              Tab(
                icon: Icon(Icons.table_chart),
                text: 'Details',
              ),
              Tab(
                icon: Icon(Icons.format_list_numbered),
                text: 'Auto test',
              ),
              Tab(
                icon: Icon(Icons.settings),
                text: 'Manual test',
              ),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              _buildDetailsView(),
              Text('Auto test'),
              Text('Manual test'),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: _buildAppBarTitle(state.peripheralInfo.name),
        ),
        body: _buildDetailsView(),
      );
    }
  }

  Widget _buildPeripheralUnavailableState(PeripheralUnavailable state) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle('Peripheral unavailable'),
      ),
      body: _buildDetailsView(),
    );
  }

  Widget _buildAppBarTitle(String name) {
    return Text(name);
  }

  Widget _buildDetailsView() {
    return PeripheralDetailsView();
  }
}
