From: "Eric Brower" <ebrower@gmail.com>
Date: Sun, 06 Aug 2006 17:07:26 +0000
Subject: Re: [PATCH] Fix E250 console with RSC
Message-Id: <ec7cefb0608061007le81b1aldbbd0d2de3c39adb@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
In-Reply-To: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 8/5/06, Marc Zyngier <maz@misterjones.org> wrote:

> Would be nice to understand the protocol between the E250 and the RSC
> (so we could have proper Linux tools to manage it), but I'm not sure
> Sun ever made it public...

I don't believe it was ever made public.  Eddie Dost did a bit of
poking at it a short while back, and I've considered taking a look as
part of the "other end" of SUNW,envctrltwo but have not yet done so.
The envctrltwo driver can dump the static configuration of the RSC,
which is a bit of a help for "lockouts" but not sufficient for
management.

-- 
E
