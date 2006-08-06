From: Daniel Smolik <marvin@mydatex.cz>
Date: Sun, 06 Aug 2006 19:54:07 +0000
Subject: Re: [PATCH] Fix E250 console with RSC
Message-Id: <44D648DF.1000609@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
In-Reply-To: <wrpwt9nk17j.fsf_-_@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Eric Brower napsal(a):
> On 8/5/06, Marc Zyngier <maz@misterjones.org> wrote:
> 
>> Would be nice to understand the protocol between the E250 and the RSC
>> (so we could have proper Linux tools to manage it), but I'm not sure
>> Sun ever made it public...
> 
> 
> I don't believe it was ever made public.  Eddie Dost did a bit of
> poking at it a short while back, and I've considered taking a look as
> part of the "other end" of SUNW,envctrltwo but have not yet done so.
> The envctrltwo driver can dump the static configuration of the RSC,
> which is a bit of a help for "lockouts" but not sufficient for
> management.
> 

But you say me  that is possible craate or delete user account for RSC via 
envctrltwo and piece of software. Only one thing that I use Solaris was creating 
RSC user account because I get E250 without RSC user account. All other thing I 
can do under linux.

			Dan

