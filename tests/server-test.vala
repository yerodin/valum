/*
 * This file is part of Valum.
 *
 * Valum is free software: you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version.
 *
 * Valum is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Valum.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;
using VSGI;

public int main (string[] args) {
	Test.init (ref args);

	Test.add_func ("/server/new/http", () => {
		var server = Server.@new ("http");
		assert ("VSGIHTTPServer" == server.get_type ().name ());
	});

	Test.add_func ("/server/new/cgi", () => {
		var server = Server.@new ("cgi");
		assert ("VSGICGIServer" == server.get_type ().name ());
	});

	Test.add_func ("/server/new/scgi", () => {
		var server = Server.@new ("scgi");
		assert ("VSGISCGIServer" == server.get_type ().name ());
	});

	Test.add_func ("/server/new/fastcgi", () => {
		var server = Server.@new ("fastcgi");
		assert ("VSGIFastCGIServer" == server.get_type ().name ());
	});

	Test.add_func ("/server/new/mock", () => {
		var server = Server.@new ("mock");
		assert ("VSGIMockServer" == server.get_type ().name ());
	});

	Test.add_func ("/server/fork", () => {
		var server = Server.@new ("mock");
		var pid = server.fork ();

		assert (pid != -1);

		if (pid == 0) {
			assert (0 == server.workers.length ());
			Process.abort ();
		} else {
			assert (1 == server.workers.length ());
			assert (pid == server.workers.data);
		}
	});

	return Test.run ();
}
