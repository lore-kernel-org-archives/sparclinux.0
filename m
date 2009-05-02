From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 02 May 2009 10:25:37 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090502102537.GB6558@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Apr 28, 2009 at 01:44:57AM -0700, David Miller wrote:
> It won't, most likely because the device name is totally different
> for Niagara's console device vs. the serial console device used
> on all other types of boxes.

Installer's rootskel uses the attached code to detect whether console
is serial or not (by checking whether ioctl(0, TIOCGSERIAL, buffer)
succeeds). Can you compile and run it on Niagara's serial console, to
see whether this mechanism detects it correctly?

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
