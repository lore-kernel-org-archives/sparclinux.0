From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 13 Mar 2010 18:42:39 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1268505759.1775.74.camel@deblnxsrv254.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 2010-03-13 at 18:57 +0100, Frans van Berckel wrote:
> On Fri, 2010-03-12 at 00:08 -0800, David Miller wrote: 
> > 
> > I look forward to it :-)
> 
> It boot's! 
> 
> [    0.000000] OF stdout device
> is: /upa@8,480000/SUNW,gfb@0,0:r1440x900x60
> 
> Next the screen is switching into blue letters, it scrolls on and on, as
> expected. At the end it prints a blinking cursor. It freezes the cursor.
> But the system goes on and is still accessible with ssh.
> 
> Attaching the dmesg ...

It does not freeze. It's a init switch but did not install Xorg.  With a
Alt-F1 I can switch the consoles and being able to login.

