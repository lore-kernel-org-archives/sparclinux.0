From: "David S. Miller" <davem@redhat.com>
Date: Mon, 05 Jan 2004 19:04:09 +0000
Subject: Re: [PATCH] Re: Oops on 2.6.1-rc1 serial access
Message-Id: <20040105110409.01ae3342.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073198287.3960.38.camel@ori.thedillows.org>
In-Reply-To: <1073198287.3960.38.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04 Jan 2004 01:38:07 -0500
David Dillow <dave@thedillows.org> wrote:

> Sunzilog was telling the serial core that we were going to register 4
> ports, but then only registered 2. Serial core was calling uart_close()
> on ports that had never been set up (ttyS2 & ttyS3), therefore the
> illegal access.
> 
> The attached patch teaches Sunzilog to not count ports attached to a
> keyboard or mouse when registering with serial_core. With this patch, I
> no longer get an oops when opening the problem ports.

Looks great, patch applied.

Thanks David.
