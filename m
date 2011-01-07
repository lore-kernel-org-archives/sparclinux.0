From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 07 Jan 2011 22:41:51 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110107224151.GA10353@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> What kernel version are you running exactly? config says 2.6.36-rc7, if
> so it's missing other fixes related to the console handover.
> 
> Basically, grab 2.6.37 that was released a day ago and apply the patch.
> 
> If the problem persist, please comment out the call to
> unregister_console and boot with -p. That should give us enough extra
> output to see where it's hanging.

Just a quick status.
I used HEAD from mainline today as it included all my sparc patches.
[Initially it oopsed but this was unrelated].

After enabling all ATYFB related options in the config
I could see that it got probed and I got output on the screen.

There is a few seconds period with no output.
Then I get output where all text are displayed in four coloums, where
two of the coloums are copies.
I can see the cursor is rapidly moving around on the screen - or
at least it looks like a cursor.

I tried to change resolution like this:

prom> setenv output-device=screen:x1024x768x70
prom> reset-all

I then used:
prom> cd /pci/SUNW,m64B
prom> .properties

This showed that the new resolution had been stored.

But this had no effect on he output :-(

Anyway.
I can see that we suceed callign the setup function that David fixes.
And what I see now is most likely a driver issue.

For now I will just accept that I need to use serial.
I may revist this later.

	Sam
