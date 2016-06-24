resource "aws_route_table_association" "aws_forklift_app1a_rta" {
  subnet_id = "${aws_subnet.application_public_1.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
resource "aws_route_table_association" "aws_forklift_app2a_rta" {
  subnet_id = "${aws_subnet.application_public_2.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
resource "aws_route_table_association" "aws_forklift_app3a_rta" {
  subnet_id = "${aws_subnet.application_public_3.id}"
  route_table_id = "${aws_route_table.default_public.id}"
}
