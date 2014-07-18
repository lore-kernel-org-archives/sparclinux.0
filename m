From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Jul 2014 07:37:59 +0000
Subject: Re: Sparc: Fix Mes in highmem.c
Message-Id: <20140718073758.GA20028@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAPDOMVjTxTNTfgPJMz6eNfabXuvtJ43YMpEeDEQ236EtF168Cg@mail.gmail.com>
 <20140717075204.GA15569@ravnborg.org>
 <CAPDOMVjb_JxnGSTf5mW_RQ58h4-7fS6HywARpPV3XgWA33SybQ@mail.gmail.com>
 <CAPDOMVj9GcoC26Sp6sOmwZf39mfOn=Wy87AnfzDguthcFOTXhg@mail.gmail.com>
In-Reply-To: <CAPDOMVj9GcoC26Sp6sOmwZf39mfOn=Wy87AnfzDguthcFOTXhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Krause <xerofoify@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jul 17, 2014 at 11:05:12PM -0400, Nick Krause wrote:
> On Thu, Jul 17, 2014 at 1:38 PM, Nick Krause <xerofoify@gmail.com> wrote:
> > On Thu, Jul 17, 2014 at 3:52 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> >> On Wed, Jul 16, 2014 at 10:25:30PM -0400, Nick Krause wrote:
> >>> I am hitting three Fix mes in this file and am wondering as the
> >>> maintainer how you would like
> >>> to clean them up.
> >>
> >> They may be addressed if we one day decide to give the sparc32 highmem
> >> support a big overhaul. Until then they are left as is.
> >>
> >>         Sam
> >  Very well then I will just not touch it until we are going to
> > overhaul the highmem  for
> > sparc32.
> > Cheers Nick
> If you want I can fix the sparc32 highmem area with your help.

This is not just something that one can jump on fixing.

	Sam
