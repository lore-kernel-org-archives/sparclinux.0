From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 07 Aug 2004 23:54:39 +0000
Subject: Re: sun4d SMP?
Message-Id: <20040807235439.GA17188@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b476569a040807050354b75f39@mail.gmail.com>
In-Reply-To: <b476569a040807050354b75f39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Aug 07, 2004 at 05:03:25AM -0700, Adam Hunt wrote:
> I heard that headway had been made on SMP support for the sun4d.  Is
> that true?  I found someone with a quad 85MHz 1000E locally and I
> would really like to add it to my network but if I am only going to
> get one proc up it isn't really worth it.

Not directly, no. I committed minimalistic changes to get the stuff to
compile. This was so that viro could do sparse work on the relevant
arch code. sun4d work will begin in earnest when I get hardware access
(which is planned to happen, just a month or two off).


-- wli
