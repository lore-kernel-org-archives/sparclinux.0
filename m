From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 02 Aug 2004 18:09:33 +0000
Subject: Re: Question about recent copy_user.S change
Message-Id: <20040802180933.GI7321@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040801192158.GB7321@artsapartment.org>
In-Reply-To: <20040801192158.GB7321@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Aug 02, 2004 at 12:00:30PM -0500, Tom 'spot' Callaway wrote:
> On Sun, 2004-08-01 at 14:21 -0500, Art Haas wrote:
> 
> > Also, just what was the problem with gcc-3.3 that was
> > resolved by adding the parenthesis? Macro mis-expansion I'm guessing.
> 
> Yep. That was it.
> 

OK. As the memcpy.S file has similiar macros, is it not susceptible to
the same mis-expansion?

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
