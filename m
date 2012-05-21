From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 May 2012 18:38:07 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20120521183807.GA6104@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521.050300.1434374935904126254.davem@davemloft.net> <CA+55aFzag=LfduvHSmE34nEVYOk=MRhUMzK854+icLwthmz5Ng@mail.gmail.com> <20120521182400.GA6043@merkur.ravnborg.org> <CA+55aFymRE-_1qzCA_n3xYbMseQrZsjJWWX74S3jn5Qyf9Efjw@mail.gmail.com>
In-Reply-To: <CA+55aFymRE-_1qzCA_n3xYbMseQrZsjJWWX74S3jn5Qyf9Efjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 21, 2012 at 11:28:58AM -0700, Linus Torvalds wrote:
> On Mon, May 21, 2012 at 11:24 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > So the "if NET" part in the select is redundant but not strictly wrong.
> 
> It's not redundant.
> 
> Try doing a "make ARCH=sparc allnoconfig" without it. It will warn.
> 
> I didn't bother looking at *why* it warns, but all other architectures
> have the "if NET" part.

I see. This is because HAVE_BPF_JIT depends on NET, so kconfig
warns if you select HAVE_BPF_JIT without NET enabled.
The correct fix is obviously to move HAVE_BPF_JIT so it
does not depend on NET.

Sprinkling "if NET" all over is the wrong fix.

	Sam
