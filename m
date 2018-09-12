From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Wed, 12 Sep 2018 14:41:19 +0000
Subject: Re: [PATCH 00/25] Change tty_port(standard)_install's return type
Message-Id: <20180912154119.1fce639d@alans-desktop>
List-Id: <sparclinux.vger.kernel.org>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>

On Tue,  4 Sep 2018 11:44:26 +0900
Jaejoong Kim <climbbb.kim@gmail.com> wrote:

> Many drivers with tty use the tty_stand_install(). But, there is no
> need to handle the error, since it always returns 0.


And what happens if another change means it can fail again. It's just a
property of the current implementation that it can't. It used to fail.

This seems to be a ton of unneccessary churn that will end up just having
to be reversed again some day in the future.

Alan
