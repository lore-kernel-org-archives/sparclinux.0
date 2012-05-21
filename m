From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 May 2012 18:33:12 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFy4He9X6wQjATaJukzH1FkyhGqnmC4kb+azKuMmjPGbmg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521.050300.1434374935904126254.davem@davemloft.net>
 <CA+55aFzag=LfduvHSmE34nEVYOk=MRhUMzK854+icLwthmz5Ng@mail.gmail.com>
 <20120521182400.GA6043@merkur.ravnborg.org> <CA+55aFymRE-_1qzCA_n3xYbMseQrZsjJWWX74S3jn5Qyf9Efjw@mail.gmail.com>
In-Reply-To: <CA+55aFymRE-_1qzCA_n3xYbMseQrZsjJWWX74S3jn5Qyf9Efjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 21, 2012 at 11:28 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I didn't bother looking at *why* it warns, but all other architectures
> have the "if NET" part.

Ok, I looked now, and it's because the definition of HAVE_BPF_JIT is
inside the "if NET" thing.

So if NET isn't enabled, then HAVE_BPF_JIT doesn't really *exist* as
an option. Doing a "select" on it is thus not a good idea.

I bet you could just move the two lines

  config HAVE_BPF_JIT
          bool

up to the top of net/Kconfig (so that HAVE_BPF_JIT is available
unconditionally), and then remove all the "if NET" from the four
architectures that support it.

                  Linus
