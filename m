From: "C.Newport" <crn@netunix.com>
Date: Tue, 03 Feb 2004 21:26:35 +0000
Subject: Re: Was:  Problems with bridging on Sparc64
Message-Id: <200402032126.35915.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200402031553.44155.crn@netunix.com>
In-Reply-To: <200402031553.44155.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 03 February 2004 8:18 pm, Ben Collins wrote:
> > What does the team think ?
>
> I think you have no clue about the intracacies of managing a
> distribution. Debian's already started dealing with this. None of it has
> to do with compatibility with other dists. It's all package management,
> and it's all dist specific.
>
> About the only standard is /lib64:/usr/lib64 for libraries.

Not completely ignorant <B-).
I am currently working on the next release of the Splack installer
so I am trying to think ahead. The Splack 8.0 installer was a 
learning experience, this one is a chance to do better.
I am a bit constrained by the policy of retaining the
Slackware look and feel, but the Sparc stuff is far less simple
than X86 with  $ARCH kernel variants to worry about as well as
needing to support tftp installs and diskless Javastations.

It would be nice to have some form of standardisation in where 64 bit
things finally end up after the install, most Linux distributions seem
to put most things in fairly standard places but I am concerned that
the migration to 64 bit is likely to be chaotic unless some de-facto
standards are in place. 

We should take pity on the developer of some nice 64 bit application 
who tries to get his install scripts to work on all common Linux 
distributions. Portability between distributions is a major headache
for application developers.

