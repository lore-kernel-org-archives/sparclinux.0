From: Heitzso <heitzso@bellsouth.net>
Date: Sat, 14 May 2005 12:26:34 +0000
Subject: sparc32 2.6 work
Message-Id: <4285EE7A.7090200@bellsouth.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

(if there's a specific email list I should focus on please let me know,
or a particular individual/mentor I can work through on this to avoid
having simple/trivial emails hassle a list .... thanks)

I figured out patching 2.6.12 rc against base 2.6.11 and not 2.6.11.X

I setup serial console as recommended by a few folks to better
monitor the boot sequence.

Next minor problem was/is that modules were not automagically loading
(though that was set in .config) so every module that may be
necessary has to be explicitly tagged in
/etc/modules.autoload.d/kernel-2.6
This may be gentoo specific, I don't know.  But I needed to
add in the HME/LANCE modules so the network would crank up
and sshd start, allowing me to sshd in (as well as serial console
login), along with others.

With that working I reattached keyboard/monitor and rebooted.
Still getting initial invisible boot screen, but by the time
the gentoo /etc/init.d scripts are running the monitor is
visible.

Trying to log on with the attached keyboard/monitor is rather
horribly broken in the keyboard.  I have sun keyboard compiled
into the kernel (not a module).  Don't have a competing keyboard
compiled in.  My config was based on 2.4.30 config run through
oldconfig, then hand tweaked.  (and my 2.4.30 SMP gives good
messages to attached monitor/keyboard, keyboard works, and
X works for at least a few minutes before locking up the 2.4.30
SMP kernel).

Then, running 2.6.12-rc4 UP on ross hypersparc ss20, after being
up about 8 hours and while editing in vi, the filesystem(s) just
disappeared.  By disappearing "ls" returns blank and "df -m"
hangs.

I have a regular single supersparcII cpu that I could drop into
the ss20 if that's recommended, but the whole gentoo env is
compiled with some ross hypersparc flags.  I don't know if that's
a problem or not.

SO ....

I've offered to try and help with the sparc32 port of 2.6 and
am wondering where I should start.  Seems like it makes sense
to get UP solid before jumping into the world of SMP, but it
may be my above problems are not really problems, or have simple
solutions.

If someone could do a little hand holding and/or point out a
small area of code for me to jump into I'll be glad to try to
help fix the code.  But I need that mentoring because the above
problems, much less SMP, seem to be all over the map ...


Thanks,
Heitzso
