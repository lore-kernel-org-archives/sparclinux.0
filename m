From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Sat, 07 Feb 2009 19:24:20 +0000
Subject: Re: SILO problems
Message-Id: <498DDFE4.4020105@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2009-02-07 at 5:32:52 -0500, David Miller <davem@davemloft.net> wrote:
> I notice that I have none of those funny flags set, and my
> boot partition starts at zero and is of type "1" or Sun partition
> type "Boot".
> 
> Perhaps one of those two things makes a difference.

Your boot partition needs to start on 0, or silo can't be loaded by the
OBP. Hit this the hard way debugging the Fedora installer. :)

~spot
