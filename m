From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 May 2012 18:28:58 +0000
Subject: Re: [GIT] Sparc
Message-Id: <CA+55aFymRE-_1qzCA_n3xYbMseQrZsjJWWX74S3jn5Qyf9Efjw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521.050300.1434374935904126254.davem@davemloft.net>
 <CA+55aFzag=LfduvHSmE34nEVYOk=MRhUMzK854+icLwthmz5Ng@mail.gmail.com> <20120521182400.GA6043@merkur.ravnborg.org>
In-Reply-To: <20120521182400.GA6043@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 21, 2012 at 11:24 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> So the "if NET" part in the select is redundant but not strictly wrong.

It's not redundant.

Try doing a "make ARCH=sparc allnoconfig" without it. It will warn.

I didn't bother looking at *why* it warns, but all other architectures
have the "if NET" part.

                   Linus
