import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:instagrao/widgets/view/view.widget.dart';

// ProductsScreen is a StatefulWidget. This allows us to update the state of the
// Widget whenever an item is removed.
class ProductsScreen extends StatefulWidget {
  ProductsScreen({Key key}) : super(key: key);

  @override
  _ProductsScreen createState() => _ProductsScreen();
}

class _ProductsScreen extends State<ProductsScreen> {
  final items = List<String>.generate(3, (i) => "Item ${i + 1}");

  _showSnackBar(action, index) {
    if (action == 'Delete') {
      // Remove the item from our data source.
      setState(() {
        items.removeAt(index);
      });
    }

    // Then show a snackbar!
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('$action: $index')));
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Products';

    return View(
      title: title,
      enableDefaultPadding: false,
      child: Container(
        height: double.maxFinite,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return new Slidable(
              delegate: new SlidableDrawerDelegate(),
              actionExtentRatio: 0.25,
              child: new Container(
                color: Colors.white,
                child: new ListTile(
                  leading: new CircleAvatar(
                    backgroundColor: Colors.indigoAccent,
                    child: new Text('$index'),
                    foregroundColor: Colors.white,
                  ),
                  title: new Text('$item'),
                  subtitle: new Text('SlidableDrawerDelegate'),
                ),
              ),
              actions: <Widget>[
                new IconSlideAction(
                  caption: 'Archive',
                  color: Colors.blue,
                  icon: Icons.archive,
                  onTap: () => _showSnackBar('Archive', index),
                ),
                new IconSlideAction(
                  caption: 'Share',
                  color: Colors.indigo,
                  icon: Icons.share,
                  onTap: () => _showSnackBar('Share', index),
                ),
              ],
              secondaryActions: <Widget>[
                new IconSlideAction(
                  caption: 'More',
                  color: Colors.black45,
                  icon: Icons.more_horiz,
                  onTap: () => _showSnackBar('More', index),
                ),
                new IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () => _showSnackBar('Delete', index),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
