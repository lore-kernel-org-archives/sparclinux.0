From: Aaron Wirtz <awirtz@novapointe.com>
Date: Tue, 06 Jan 2004 03:06:49 +0000
Subject: Re: socal
Message-Id: <200401051906.49968.awirtz@novapointe.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_JZi+/Fa7EvwHJV/"
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
To: sparclinux@vger.kernel.org


--Boundary-00=_JZi+/Fa7EvwHJV/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 31 December 2003 19:10, Aaron Wirtz wrote:
> I will do a compile and will try the driver on Monday.

Well, (as expected) this didn't work.  The machine freezes when the module 
loads.  I at least got the module to compile without complaining with the 
debugging turned on (patch to fix the debugging calls and the ucode size is 
attached).  I also got the ucode extraction working right (new script 
attached; cleaner, fixed endianness and datasize bugs).  I'll have to try the 
2.2.x kernel version next. (to see if it is just a 2.4 issue).

-Aaron Wirtz


--Boundary-00=_JZi+/Fa7EvwHJV/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="socal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="socal.patch"

--- linux-2.4.23-old/drivers/fc4/socal.c	2003-06-13 07:51:33.000000000 -0700
+++ linux-2.4.23/drivers/fc4/socal.c	2004-01-05 14:10:48.000000000 -0800
@@ -82,7 +82,7 @@
 }
 
 #ifdef HAVE_SOCAL_UCODE
-static void socal_bzero(unsigned long xram, int size)
+static void socal_bzero(unsigned long xram, unsigned long size)
 {
 	while (size) {
 		sbus_writel(0, xram);
@@ -229,7 +229,7 @@
 	SOCAL_SETIMASK(s, s->imask & ~(cmd & SOCAL_CMD_REQ_QALL));
 	SOD(("imask %08x %08x\n", s->imask, sbus_readl(s->regs + IMASK)));
 
-	SOD(("Queues available %08x OUT %X\n", cmd, s->regs->reqpr[0]))
+	SOD(("Queues available %08x OUT %X\n", cmd, (u32)(s->regs + REQP)));
 	if (s->port[s->curr_port].fc.state != FC_STATE_OFFLINE) {
 		fcp_queue_empty ((fc_channel *)&(s->port[s->curr_port]));
 		if (((s->req[1].in + 1) & s->req[1].last) != (s->req[1].out))
@@ -447,7 +447,7 @@
 		qno = 1;
 	else
 		qno = 0;
-	SOD(("Putting a FCP packet type %d into hw queue %d\n", fcmd->proto, qno))
+	SOD(("Putting a FCP packet type %d into hw queue %ld\n", fcmd->proto, qno))
 	if (s->imask & (SOCAL_IMASK_REQ_Q0 << qno)) {
 		SOD(("EIO %08x\n", s->imask))
 		return -EIO;
@@ -457,7 +457,7 @@
 	
 	if (cq_next_in == sw_cq->out &&
 	    cq_next_in == (sw_cq->out = sbus_readb(s->regs + REQP + qno))) {
-		SOD(("%d IN %d OUT %d LAST %d\n",
+		SOD(("%ld IN %d OUT %d LAST %d\n",
 		     qno, sw_cq->in,
 		     sw_cq->out, sw_cq->last))
 		SOCAL_SETIMASK(s, s->imask | (SOCAL_IMASK_REQ_Q0 << qno));
@@ -605,7 +605,7 @@
 static inline void socal_download_fw(struct socal *s)
 {
 #ifdef HAVE_SOCAL_UCODE
-	SOD(("Loading %ld bytes from %p to %p\n", sizeof(socal_ucode), socal_ucode, s->xram))
+	SOD(("Loading %ld bytes from %p to %p\n", sizeof(socal_ucode), socal_ucode, (u32 *)s->xram))
 	socal_copy_to_xram(s->xram, socal_ucode, sizeof(socal_ucode));
 	SOD(("Clearing the rest of memory\n"))
 	socal_bzero (s->xram + sizeof(socal_ucode), 65536 - sizeof(socal_ucode));

--Boundary-00=_JZi+/Fa7EvwHJV/
Content-Type: text/x-perl;
  charset="iso-8859-1";
  name="getucode.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="getucode.pl"

#!/usr/bin/perl
use warnings;
use strict;

unless(scalar(@ARGV) == 3)
{
    print "Usage: getucode.pl inputfile symbol outputfile\n";
    print "e.g.: getucode.pl socal socal_ucode socal_asm.h\n";
    exit;
}

my @symbols = split(/\n/, `objdump -t $ARGV[0]`);
@symbols = grep{/\s$ARGV[1]$/}(@symbols);
my($offset, $section, $length) = (split(/\s+/, $symbols[0]))[0, 3, 4];

my @sections = split(/\n\s*/, `objdump -h $ARGV[0]`);
@sections = grep{/\s$section\s/}(@sections);
$section = (split(/\s+/, $sections[0]))[5];

$offset = hex($offset) + hex($section);
$length = hex($length);

open INPUT, $ARGV[0];
seek INPUT, $offset, 0;
my $data;
read INPUT, $data, hex($length);
close INPUT;

# this is necessary because socal.c copies the data 4 bytes at a time,
# so the length needs to be a multiple of 4.
while($data =~ s/\x00{4}$//s){}

open OUTPUT, ">$ARGV[2]";
print OUTPUT "static __u8 socal_ucode[] __initdata = {\n";
my $counter = 0;
for(split '',$data)
{
    print OUTPUT '0x'.unpack('H2', $_).(++$counter%16==0?",\n":',');
}
print OUTPUT "};\n";
close OUTPUT;

--Boundary-00=_JZi+/Fa7EvwHJV/--

