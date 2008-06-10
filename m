From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 10 Jun 2008 16:23:10 +0000
Subject: Re: make install :)
Message-Id: <20080610162310.GA3917@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080610122333.GA12879@orion.carnet.hr>
In-Reply-To: <20080610122333.GA12879@orion.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 10, 2008 at 02:23:33PM +0200, Josip Rodin wrote:
> Hi,
> 
> I know I've said this a few months ago already, but can the install target
> be added eventually? :)
> 
> gzip -c vmlinux > vmlinuz && installkernel 2.6.25.5 vmlinuz System.map

Could you try to cook up a patch then I can take a look.
I do not have time to do it myself atm.

	Sam
