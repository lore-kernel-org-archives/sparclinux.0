From: Alex McWhirter <alexmcwhirter@triadic.us>
Date: Mon, 08 Aug 2016 04:23:05 +0000
Subject: QLogicPTI Hangs on SPARC64
Message-Id: <1470630185.2253.21.camel@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

This is a bug i've been playing with for a while now, but i think i've
narrowed it down about as far as i can without additional help. I
belive we are hitting this bit of code, as i have seen the message
before in previous panics.

toss_command:
	printk(KERN_EMERG "qlogicpti%d: request queue overflow\n",
	       qpti->qpti_id);

	/* Unfortunately, unless you use the new EH code, which
	 * we don't, the midlayer will ignore the return value,
	 * which is insane.  We pick up the pieces like this.
	 */
	Cmnd->result = DID_BUS_BUSY;
	done(Cmnd);
	return 1;

Correct me if i'm wrong, but i don't how we're pickuping up any peices
here. Something went wrong and SCSI requests built up to an
unmanageable point and we just say the bus is busy? Granted i'm not
really sure how you would pick up any peices in that case unless you
set the bus busy before the queue were to overflow and just try to wait
it out.

Take a look at the iostat information below. iostat was configured to
refresh every second, the bottom was cut off during the panic.

iostat log > http://pastebin.com/ea96AucT

From this you can see that sdc was the first drive to stop responding.
it's r/s and w/s drop to zero but the util% stays at 100. Shortly
after, the request queue overflows and sets the whole bus to busy which
can be seen in the last portion of the log (which didn't finish as the
system panic'd). All of the disks on that bus have subsequently
followed suite with sdc because the bus is essnstially screeching to a
halt.

Below you will find the kernel panic.

kernel panic > http://pastebin.com/n9agfz1z

Again, correct me if i'm wrong, but it would seem that any pointers
pointing towards the request queue are now invalid as the queue has
overflown.

Below is just some conjecture on my part.

Should the correct behaviour here not be to fail the disk that is
holding up the rest of the bus? From what i see, it is quite likely sdc
is bad so i will be replacing it, however having the whole system panic
because of a bad disk seems counter intuitive. I realise this is quite
an old driver, and may have been written before we had ways of dealing
with these types of issues. Or perhaps even, it's a a hardware
limitation that prevents up from pinpointing what is acutally no longer
responding on the bus? 
