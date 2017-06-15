From: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 15 Jun 2017 07:51:37 +0000
Subject: Re: gcc 7.1 sparc64 fixes
Message-Id: <20170615075137.GA26883@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170615073902.GZ26922@waldemar-brodkorb.de>
In-Reply-To: <20170615073902.GZ26922@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: stable@vger.kernel.org, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

On Thu, Jun 15, 2017 at 09:39:03AM +0200, Waldemar Brodkorb wrote:
> Hi,
> 
> I would like to suggest following patch for 4.4/4.9 stable
> kernel releases to fix gcc 7.1 compile issues:
> 
> Subject: [PATCH] sparc64: make string buffers large enough
> Commit: b5c3206190f1fddd100b3060eb15f0d775ffeab8

No objection from me, David, mind if I queue this up?

thanks,

greg k-h
