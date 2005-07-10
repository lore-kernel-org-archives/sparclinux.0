From: Ben Collins <bcollins@debian.org>
Date: Sun, 10 Jul 2005 00:44:14 +0000
Subject: Re: Desperate after upgrading OBP from 3.11 to 3.31
Message-Id: <20050710004413.GD2972@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <42D04BC9.9060105@dhcp.net>
In-Reply-To: <42D04BC9.9060105@dhcp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

What's your silo.conf look like?

On Sun, Jul 10, 2005 at 02:25:35AM +0200, A. Eijkhoudt wrote:
> Hi Ben,
> 
> Thanks for responding. I have, but to no avail. I've tried running SILO 
> with multiple exotic combinations such as -f and -u to force it to 
> rewrite the bootblock for my Ultra. What I don't understand is how the 
> boot sector could get corrupted in the first place. I've also tried 
> putting the first partition back at 'Start = 0' now; no deal.
> 
> Kind regards,
> 
> Arnim
> 
> Ben Collins wrote:
> >After booting from CD, rerun the silo command. Sounds like your boot
> >sector got corrupted, or you moved second.b on your filesystem without
> >rerunning silo.
> >
> >On Sun, Jul 10, 2005 at 12:12:25AM +0200, A. Eijkhoudt wrote:
> >
> >>Hello all,
> >>
> >>I've upgraded my OBP from 3.11 to 3.31 and now my SUN won't boot 
> >>anymore. Whatever I try at the 'ok' prompt has no effect, it keeps 
> >>saying 'The file just loaded does not appear to be executable'. I've 
> >>tried pretty much all versions of 'boot disk#:#' by now. The system in 
> >>question is a SUN Ultra10, 300MHz, 320MB RAM, 40GB HD Maxtor 6E040L.
> >>
> >>Partition layout:
> >>
> >><snip>
> >>Disk /dev/ide/host0/bus0/target0/lun0/disc (Sun disk label): 16 heads, 
> >>63 sectors, 16383 cylinders
> >>Units = cylinders of 1008 * 512 bytes
> >>
> >>                               Device Flag    Start       End 
> >>Blocks   Id  System
> >>/dev/ide/host0/bus0/target0/lun0/part1             1       101     50400 
> >> 83  Linux native
> >>/dev/ide/host0/bus0/target0/lun0/part2           101     79144  39837672 
> >> 83  Linux native
> >>/dev/ide/host0/bus0/target0/lun0/part3             0     79656  40146624 
> >>  5  Whole disk
> >>/dev/ide/host0/bus0/target0/lun0/part4  u      79147     79655    256032 
> >> 82  Linux swap
> >>
> >>Disk /dev/ide/host0/bus0/target0/lun0/part3 (Sun disk label): 16 heads, 
> >>63 sectors, 16383 cylinders
> >>Units = cylinders of 1008 * 512 bytes
> >>
> >>                                Device Flag    Start       End 
> >>Blocks   Id  System
> >>/dev/ide/host0/bus0/target0/lun0/part3p1             1       101 
> >>50400   83  Linux native
> >>/dev/ide/host0/bus0/target0/lun0/part3p2           101     79144 
> >>39837672   83  Linux native
> >>/dev/ide/host0/bus0/target0/lun0/part3p3             0     79656 
> >>40146624    5  Whole disk
> >>/dev/ide/host0/bus0/target0/lun0/part3p4  u      79147     79655 
> >>256032   82  Linux swap
> >></snip>
> >>
> >>As you can see, I can boot fine from CD...
> >>
> >>My SILO configuration:
> >>
> >><snip>
> >>partition=1
> >>root=/dev/hda2
> >>timeout
> >>device=/dev/hda
> >>image=/boot/2.6.12
> >>       label=linux
> >>image=/boot/2.6.12-old
> >>       label=old
> >></snip>
> >>
> >>This is all correct:
> >>
> >><snip>
> >>livecd ~ # ls /boot/
> >>2.6.12      System.map         System.map-2.6.12-old  fd.b     generic.b 
> >>isofs.b     old.b     silo.conf   ultra.b
> >>2.6.12-old  System.map-2.6.12  boot                   first.b  ieee32.b 
> >> lost+found  second.b  silotftp.b
> >></snip>
> >>
> >>Running SILO yields no errors... Can someone please help? There has to 
> >>be a simple way of fixing this, and I really don't believe I'm the only 
> >>one who has ever had this problem either. I've already spent 5(!) hours 
> >>reading every single search result I could find on Google and on the 
> >>Gentoo forums about this... My SUN is pretty much dead in the water 
> >>right now, as I don't feel like booting from a LiveCD just to get it 
> >>beyond the OpenBoot POST.
> >>
> >>Kind regards,
> >>
> >>Arnim Eijkhoudt
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
