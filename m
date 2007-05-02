From: ludo@chbouib.org (Ludovic =?iso-8859-1?Q?Court=E8s?=)
Date: Wed, 02 May 2007 18:00:45 +0000
Subject: Re: ICE with GCC 4.1
Message-Id: <87647bp0ky.fsf@chbouib.org>
List-Id: <sparclinux.vger.kernel.org>
References: <87odl4qt19.fsf@chbouib.org>
In-Reply-To: <87odl4qt19.fsf@chbouib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> Does it always error out at the same point? You might want to use a memory
> tester.

Yes, always at the same point, which led me to think it was more of a
software problem.  I even reported the same error while compiling an
older kernel a while back:

  http://article.gmane.org/gmane.linux.ports.sparc/6239

Back then, using GCC 3 wouldn't help either:

  http://article.gmane.org/gmane.linux.ports.sparc/6290

Am I really the only one seeing this?  Which compiler do distros use?

Thanks,
Ludovic.

