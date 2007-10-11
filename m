From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2007 21:49:28 +0000
Subject: Re: [2.6 patch] esp_scsi.c: remove __dev{init,exit}
Message-Id: <20071011.144928.45188136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1192109439.3352.11.camel@localhost.localdomain>
	<20071011153520.GA16424@stusta.de>
	<200710111747.03119.rob@landley.net>
In-Reply-To: <200710111747.03119.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rob@landley.net
Cc: bunk@kernel.org, James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>
Date: Thu, 11 Oct 2007 17:47:02 -0500

> On Thursday 11 October 2007 10:35:20 am Adrian Bunk wrote:
> > Since scsi_esp_{,un}register() are EXPORT_SYMBOL'ed, these functions
> > (and the functions they use) can't be __dev{init,exit}.
> >
> > Based on a bug report by Rob Landley.
> >
> > Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> Acked-by: Rob Landley <rob@landley.net>

I'm fine with this fix too.

Acked-by: David S. Miller <davem@davemloft.net>
