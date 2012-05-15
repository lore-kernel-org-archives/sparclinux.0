From: Tom Callaway <tcallawa@redhat.com>
Date: Tue, 15 May 2012 15:57:45 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <4FB27CF9.5060207@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05/15/2012 01:09 AM, David Miller wrote:
> 
> It's the one aberration in v8, the only cpu that
> didn't actually have hardware multiply and divide
> instructions.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> I'm tempted to push this.
> 
> Sam, what's your take on it?

I'm not Sam, but for what its worth, I say push it. In all the years
that Aurora maintained a sparc32 build, I never once saw one or had a
user report using one (and we had people trying to run Aurora on
Javastations).

~tom

=
Fedora Project
