From: "David S. Miller" <davem@redhat.com>
Date: Thu, 15 Jan 2004 09:11:35 +0000
Subject: Re: qlogicpti on 2.6.1
Message-Id: <20040115011135.48c88f73.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
In-Reply-To: <Pine.GSO.4.58.0401141652170.15533@redfish.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 14 Jan 2004 17:00:22 -0500 (EST)
Chris Ricker <kaboom@gatech.edu> wrote:

> Does / should the SBUS qlogicpti driver work in the 2.6 kernels?

It's supposed to, but obviously it isn't from your report :)

I didn't see anything obvious by doing a cursory glance of the changes
made to this driver in 2.6.x, I'll do some more auditing tomorrow.
