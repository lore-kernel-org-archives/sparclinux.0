From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 04 May 2004 14:57:14 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504145714.GA4138@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 04, 2004 at 10:26:55AM -0400, Ben Collins wrote:

> > I don't like the original because it keeps doing strcmp() tests more
> > times than necessary. That was my motivation in doing changing this bit
> > of code.
> 
> Only happens once at boot. Can't be that much overhead. Could just add
> else's in front of the later if's, and leave the formatting the same.

Right, this is completely non-critical, and I also like the existing
formatting.  I see no good reason to change this.

-- 
Keith M Wesolowski
