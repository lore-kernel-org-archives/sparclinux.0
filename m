From: "C.Newport" <crn@netunix.com>
Date: Fri, 27 Aug 2004 23:34:12 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <200408280034.12701.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Friday 27 August 2004 11:29 pm, David S. Miller wrote:
> On Fri, 27 Aug 2004 05:30:42 -0500
>
> Ralph Mitchell <rmitchell@eds.com> wrote:
> > For the record, I found that 2.6.7-rc1 didn't drop every other
> > character, while 2.6.7-rc2 and above do.
>
> Good clue.
>
> Are all of you guys seeing this problem on uniprocessor?
> Ralph, Joshua?

FWIW, I saw this problem in a completely different non-linux context
a while ago. It is possible, if the code is tight enough, for modern fast
processors to overwrite the character in a USART transmit register
before the USART has moved it down the internal buffer. 
Introducing a suitable delay fixed it.



