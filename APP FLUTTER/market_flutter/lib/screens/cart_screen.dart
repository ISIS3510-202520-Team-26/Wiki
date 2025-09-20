import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Colores base del proyecto
  static const Color kDarkGreen = Color(0xFF014D40);
  static const Color kBgLavender = Color(0xFFF1ECF2);

  // Un único ítem en el carrito
  int qty = 1;
  final double price = 345; // USD
  final String title = "Logitech GT12";
  final String subtitle = "Mouse Wireless";

  double get total => price * qty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgLavender,
      body: SafeArea(
        child: Column(
          children: [
            // Header "My Cart" + acciones
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Text(
                    "My Cart",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ).copyWith(color: kDarkGreen),
                  ),
                  const Spacer(),
                  _RoundIconButton(
                    icon: Icons.search,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _RoundIconButton(
                    icon: Icons.more_horiz,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Lista con UN solo producto (card)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                children: [
                  _CartItemCard(
                    title: title,
                    subtitle: subtitle,
                    price: price,
                    qty: qty,
                    onAdd: () => setState(() => qty++),
                    onRemove: () => setState(() {
                      if (qty > 1) qty--;
                    }),
                    darkGreen: kDarkGreen,
                  ),
                  const SizedBox(height: 16),
                  _SummaryCard(
                    total: total,
                    darkGreen: kDarkGreen,
                    onCheckout: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Checkout pressed")),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: 2, // My Cart activo
          onTap: (i) {
            // Aquí puedes navegar a otras pantallas según el índice
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Tab $i tapped")),
            );
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: kDarkGreen,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Order"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "My Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

// ---------- Widgets de UI ----------

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 20, color: Colors.black87),
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double price;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final Color darkGreen;

  const _CartItemCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.qty,
    required this.onAdd,
    required this.onRemove,
    required this.darkGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          // Imagen cuadrada placeholder
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
                const SizedBox(height: 8),
                Text("\$${price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    )),
              ],
            ),
          ),

          // + cantidad -
          Column(
            children: [
              _QtyButton(
                icon: Icons.add,
                color: darkGreen,
                onTap: onAdd,
              ),
              const SizedBox(height: 6),
              Text("$qty",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 6),
              _QtyButton(
                icon: Icons.remove,
                color: Colors.grey.shade300,
                onTap: onRemove,
                iconColor: Colors.black54,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Color? iconColor;
  const _QtyButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(icon, size: 18, color: iconColor ?? Colors.white),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final double total;
  final Color darkGreen;
  final VoidCallback onCheckout;

  const _SummaryCard({
    required this.total,
    required this.darkGreen,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.8),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              Text("Total",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  )),
              const Spacer(),
              Text("\$${total.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text("Checkout", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
