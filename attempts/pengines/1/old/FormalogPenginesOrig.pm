package FormalogPengines;

use PerlLib::SwissArmyKnife;

use Moose;
use Try::Tiny;

use Inline Java => <<'END_OF_JAVA_CODE',
/**
 * Copyright (c) 2016 Simularity Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.simularity.os.javapengine.example;

import java.net.MalformedURLException;

import com.simularity.os.javapengine.Pengine;
import com.simularity.os.javapengine.PengineBuilder;
import com.simularity.os.javapengine.Proof;
import com.simularity.os.javapengine.Query;
import com.simularity.os.javapengine.exception.CouldNotCreateException;
import com.simularity.os.javapengine.exception.PengineNotReadyException;

/**
 * @author anniepoo
 *
 */
public abstract class ManualAsk {

	/**
	 * 
	 */
	private ManualAsk() {
		// class only exists to call main on
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
	    DoMain();
	}

	/**
	 * @param args
	 */
	public static void DoMain() {
		PengineBuilder po = new PengineBuilder();
		try {
			po.setServer("http://localhost:9880/");
			Pengine p = po.newPengine();
			p.dumpStateDebug();
			for(Query q = p.ask("member(X, [a(taco),2,c])"); q.hasNext() ; ) {
				Proof proof = q.next();
				
				System.out.println(proof.toString());
			}
			p.dumpStateDebug();
			
			System.err.println("now make one that sticks around");
			po.setDestroy(false);
			Pengine p2 = po.newPengine();
			p2.dumpStateDebug();
			for(Query q = p2.ask("member(X, [a(taco),2,c])"); q.hasNext() ; ) {
				Proof proof = q.next();
				
				System.out.println(proof.toString());
			}
			
			System.out.println("that felt good, lets do another one");
			
			for(Query q = p2.ask("(between(1,5, X), Y is 2 * X)"); q.hasNext() ; ) {
				Proof proof = q.next();
				
				System.out.println(proof.toString());
			}
			
			System.err.println("Now lets try stopping a query");
			
			for(Query q = p2.ask("between(1,5, X)"); q.hasNext() ; ) {
				Proof proof = q.next();

				System.out.println(proof.toString());
				
				if(proof.getNearestInt("X") >= 3) {
					System.out.println("ok, enough of that");
					q.stop();
				}
			}		
			System.out.println("whew, glad thats over. Lets see if the pengines still functioning");
			
			for(Query q = p2.ask("member(X, [a(taco),2,c])"); q.hasNext() ; ) {
				Proof proof = q.next();
				
				System.out.println(proof.toString());
			}
			
			p2.dumpStateDebug();
			p2.destroy();
			p2.dumpStateDebug();			
			
			po.setSrctext("speak(X,Y) :- pengine_output(X), between(1,3,Y).");
			po.setAlias("ioengine");
			po.setDestroy(false);
			
			Pengine io = po.newPengine();
			
			for(Query q = io.ask("(pengine_output('cabbages and kings'), between(1,3,X))"); q.hasNext() ; ) {
				Proof proof = q.next();
				System.out.println(proof.toString());
				
				if (proof.getNearestInt("X") < 3) {  // change this to a larger number to see it hang
					// this hangs on the last proof
					// This is referred to in https://github.com/SWI-Prolog/pengines/issues/19
					String out = io.getOutput();
					if(out != null) {
						System.out.println("I got " + out + " from the server");
					}
				}
			}
			System.out.println("End of query");
			
			io.destroy();
			
		} catch (MalformedURLException e) {
			System.err.println("Bad URL" + e.getMessage());
			e.printStackTrace();
		} catch (CouldNotCreateException e) {
			System.err.println("cannot make pengine" + e.getMessage());
			e.printStackTrace();
		} catch (PengineNotReadyException e) {
			System.err.println("pengine not ready" + e.getMessage());
			e.printStackTrace();
		}
	}


}
END_OF_JAVA_CODE
  AUTOSTUDY => 1,
  CLASSPATH => '/home/andrewdo/.m2/repository/javax/json/javax.json-api/1.0/javax.json-api-1.0.jar:/home/andrewdo/.m2/repository/org/glassfish/javax.json/1.0.4/javax.json-1.0.4.jar:/var/lib/myfrdcsas/versions/myfrdcsa-1.0/sandbox-new/javapengine-20200108/javapengine-20200108/target/classes',
  # EXTRA_JAVA_ARGS => '-Djava.library.path=',
  # # /var/lib/myfrdcsas/versions/myfrdcsa-1.0/sandbox-new/javapengine-20200108/javapengine-20200108/target/classes/com/simularity/os/javapengine/example
  DIRECTORY => "$ENV{HOME}/.Inline";

# -Xmx1g

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=pod

=head1 NAME

System::Cyc::ResearchCyc::Java::CycAccess - A wrapper for the Cyc API

=head1 SYNOPSIS

  use System::Cyc::ResearchCyc::Java::CycAccess;
  my $cyc = System::Cyc::ResearchCyc::Java::CycAccess->new;


=head1 DESCRIPTION

System::Cyc::ResearchCyc::Java::CycAccess is a wrapper for the Cyc API

=head1 EXPORTED FUNCTIONS

=head1 METHODS

=head1 BUGS

What could possibly go wrong?

If you have an error like:

Can't receive packet from JVM: or
Clips : Unsupported major.minor version 51.0

Try finding and removing the _Inline directory, which should be in the
path where the containing program was run.

=head1 TODO

Support should be added for Persistence using FreeKBS2.

=head1 AUTHOR

Andrew DoughertyE<lt>andrewdo@frdcsa.orgE<gt>

=cut
