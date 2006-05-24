From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 24 May 2006 22:02:55 +0000
Subject: Re: sigreturn on sparc64
Message-Id: <4474D80F.7020908@zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e5270r$q83$1@terminus.zytor.com>
In-Reply-To: <e5270r$q83$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> The stub is "returned to" directly from the signal handler itself
> using the "retl" instruction, which jumps to the value of "register
> %i7 plus 8".  We stick the passed in stub address directly into the
> %i7 register of the signal handler frame, that's why you need to
> subtract 8 for the system call argument.

Yup, there are a lot of things like this in the Linux ABI (something which makes sense on 
one architecture, but not across architectures); sigreturn is obviously the worst.

	-hpa
