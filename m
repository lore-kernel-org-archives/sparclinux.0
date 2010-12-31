From: Julian Calaby <julian.calaby@gmail.com>
Date: Fri, 31 Dec 2010 10:29:12 +0000
Subject: Re: [PATCH 0/5] sparc: piggyback update
Message-Id: <AANLkTik1DoE-_p7UR_uVRZ1p+x9JL_4wskSNvSmLiavn@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20101231093628.GA19496@merkur.ravnborg.org>
In-Reply-To: <20101231093628.GA19496@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Dec 31, 2010 at 20:36, Sam Ravnborg <sam@ravnborg.org> wrote:
> In an attempt to understand how tftp booting works
> I looked at unifying piggyback_32 and piggyback_64.
>
> Due to subtle differences I did not succeed in the
> unification - at least not this time around.

This was the problem I had when I tackled this ages ago.

Sadly none of my patches made it out after the fixes we did late June
2009 as I lost the free time I was working on it in.

> But I anyway created a few patches that removes
> a few differences between sparc and sparc64.
> And piggyback_32 gained a lot in readability
> as I have documented my findings using a few comments.

I've got some patches lying around to bring piggyback_64 up to
scratch, I'll post those as soon as I've rebased them.

> In the process I also removed ELF support from piggyback_32,
> as it was not used.

I'll do this for _64 too.

> Note: I have not updated piggyback_64.c because the plan was/is
> that piggyback_32 shall support both sparc and sparc64.

My idea was to create a unified piggyback that took $BITS as an
argument - then did sensible things based upon that. It never got off
the ground here.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
