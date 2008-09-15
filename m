From: Elad Lahav <elahav@uwaterloo.ca>
Date: Mon, 15 Sep 2008 21:26:38 +0000
Subject: Re: Processor IDs on the Niagara
Message-Id: <48CED30E.3050504@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <48CADADA.7050604@uwaterloo.ca>
In-Reply-To: <48CADADA.7050604@uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sorry to be nagging about this...
Maybe I should have provided some motivation in the first place:
Knowing the processor topology may be of importance to a certain class of programmes. 
Specifically, I/O-intensive applications (such as a web server), may want to ensure that 
interrupts are serviced close to the process/thread executing the service. I have run some 
tests that show that servicing interrupts on a different physical package than the one 
responsible for the synchronous part of the service can result in very poor performance 
(for obvious reasons).

> Niagara T1 is a single "package", with 8 "cores".
Exactly my point. So why isn't there a single physical package ID for all CPUs under 
/sys/devices/system/cpu/cpuX/topology/physical_package_id ?

Elad

