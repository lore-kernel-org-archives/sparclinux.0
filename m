From: Jos van der Ende <seraph@xs4all.nl>
Date: Tue, 01 Apr 2008 19:05:21 +0000
Subject: Re: [Bugme-new] [Bug 10374] New: sym53c8xx: weird behavior with
Message-Id: <20080401210521.abbb443c.seraph@xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-10374-10286@http.bugzilla.kernel.org/>
	<20080401011518.eb683cff.akpm@linux-foundation.org>
	<1207059115.3100.9.camel@localhost.localdomain>
In-Reply-To: <1207059115.3100.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

Hello all,


I did a bit more testing, and I think this may be related to the order in which modules are loaded.

If I let udev load sungem, and load sym53c8xx manually, everything works.

If I let udev load sym53c8xx, and load sungem manually, I get the non-functional network.

If I let udev load both modules, I also get the non-functional network. While udev loads sungem first and sym53c8xx later, I don't suppose it waits for one module to 'settle' before loading the next. :-)


So to sum it up, the bug is triggered if sym53c8xx is loaded before sungem is.


-- 
Jos van der Ende <seraph@xs4all.nl>
