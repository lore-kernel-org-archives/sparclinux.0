From: Tom Callaway <tcallawa@redhat.com>
Date: Sun, 13 May 2012 00:27:45 +0000
Subject: Re: [PATCH] sparc32: Pass -mcpu=v7 explicitly to gcc.
Message-Id: <4FAF0001.6090106@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120512.182057.119046891010844835.davem@davemloft.net>
In-Reply-To: <20120512.182057.119046891010844835.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05/12/2012 06:20 PM, David Miller wrote:
> 
> We should be agnostic to what gcc happens to be generating by default.

If you're dropping sun4c, why not -mcpu=v8?

~tom

=
Fedora Project
