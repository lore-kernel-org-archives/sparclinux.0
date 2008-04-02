From: Jos van der Ende <seraph@xs4all.nl>
Date: Wed, 02 Apr 2008 10:29:44 +0000
Subject: Re: [Bugme-new] [Bug 10374] New: sym53c8xx: weird behavior with
Message-Id: <20080402122944.7fe8e924.seraph@xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
References: <bug-10374-10286@http.bugzilla.kernel.org/>
	<20080401011518.eb683cff.akpm@linux-foundation.org>
	<1207059115.3100.9.camel@localhost.localdomain>
	<20080401210521.abbb443c.seraph@xs4all.nl>
	<1207081169.3100.20.camel@localhost.localdomain>
	<20080401225717.7d936f91.seraph@xs4all.nl>
	<1207084454.3100.31.camel@localhost.localdomain>
In-Reply-To: <1207084454.3100.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

Maybe it's nothing, but I did notice that sym53c8xx compiles with a warning of a possibly uninitialized variable:

  CC [M]  drivers/scsi/sym53c8xx_2/sym_glue.o
drivers/scsi/sym53c8xx_2/sym_glue.c: In function 'sym_eh_handler':
drivers/scsi/sym53c8xx_2/sym_glue.c:612: warning: 'io_reset' may be used uninitialized in this function


-- 
Jos van der Ende <seraph@xs4all.nl>
