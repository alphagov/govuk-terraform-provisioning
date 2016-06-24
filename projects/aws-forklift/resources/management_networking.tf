resource "aws_route_table_association" "aws_forklift_mp1a_rta" {
  subnet_id = "${aws_subnet.management_private_1.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
resource "aws_route_table_association" "aws_forklift_mp2a_rta" {
  subnet_id = "${aws_subnet.management_private_2.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
resource "aws_route_table_association" "aws_forklift_mp3a_rta" {
  subnet_id = "${aws_subnet.management_private_3.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
