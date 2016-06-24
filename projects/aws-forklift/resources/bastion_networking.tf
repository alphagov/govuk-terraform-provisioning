resource "aws_route_table_association" "aws_forklift_1a_rta" {
  subnet_id = "${aws_subnet.bastion_public_1.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
resource "aws_route_table_association" "aws_forklift_2a_rta" {
  subnet_id = "${aws_subnet.bastion_public_2.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
resource "aws_route_table_association" "aws_forklift_3a_rta" {
  subnet_id = "${aws_subnet.bastion_public_3.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
