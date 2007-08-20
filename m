From: Markus Dahms <mad@automagically.de>
Date: Mon, 20 Aug 2007 07:59:49 +0000
Subject: possible endless loop in PROM initialization
Message-Id: <20070820075949.GA5927@vimes.madsworld.lan>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hey,

while trying to define a non-unique devalias at the Sun PROM prompt
(the SPARCclassic X has wrong aliases for scsi, disk1, etc. in the
PROM, at least mine) I fell over a bug resulting in an endless loop
while booting the kernel.

The problem is the getting the properties list of the /aliases node.
As the next element in this list is identified by name and the
function which retrieves this property always returns the first
occurrence this goes forever....

I could track down the issue to the function __prom_nextprop() in
arch/sparc/prom/tree.c, but I am now looking for the definition of
prom_nodeops->no_nextprop() without success.

My naive solution would be to return not the first but the last
occurrence of a property.

Greetings,

	Markus

