From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 21 Jun 2016 08:15:04 +0000
Subject: Please upgrade your machines to sparc64
Message-Id: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

According to to Debian's popularity contest page [1], there are still 82 machines
reporting to be running Debian's old, unsupported sparc port (32-bit userland,
64-bit kernel). Since popcon only reports machines where the users decided to
opt-in, the number of unreported sparc installations will most certainly be
higher.

I would like to ask anyone still running the old sparc port to reinstall their
machines using the sparc64 NETINST installation image [2]. I have just done
that yesterday on a SPARC T200 server and it was very easy when you keep
a few things in mind:

  * when setting up the partitions, create a small (~1 GiB) boot partition
    which is formatted with ext3 and mounted /boot; this is required for SILO
    to work reliably and find the installed kernels
  * when prompted to enter mirror data, use the following:

    - mirror: http://ftp.ports.debian.org
    - directory: /debian-ports/

    although you won't be able to install any packages during installation
    anyway due to the missing Debian Ports signing key (see next point),
    you should still already set up the mirror data here as it will be
    used to configure your /etc/apt/sources.list for the installed system

  * ignore the error message about software packages being unable to be
    installed, just skip this step and you will be fine; you can install
    additional packages easily after rebooting the machine with the installed
    system
  * after skipping the software installation step, just let debian-installer
    finish the installation by installation SILO and completing the remaining
    tasks
  * after the machine has reset and is about to boot the installed system,
    boot the machine with "Linux console=ttyS0,9600,8n1" where "Linux"
    is the name of the configuration in SILO to be booted (defaults to
    "Linux" - view available configurations by pressing <TAB>) and
    console=ttyS0,9600,8n1 configures the serial console which is disabled
    by default currently (I will look into changing this in the future)

After system has rebooted, you should be able to log in using the root login
you created during installation. Before you will be able to install packages,
you need to install the signing key for Debian Ports manually:

# gpg --keyserver pgp.mit.edu --recv-keys 705A2CE1
# gpg --export 705A2CE1 --armor | apt-key add -
# apt-get update

After this, your system should be ready to use and you can upgrade with:

# apt-get update && apt-get upgrade

When dist-upgrading, *always* read what APT is going to do before hitting <ENTER>
and in case some important packages would be deleted, press <n> to cancel. This
issue usually resolves after a certain time when the buildds have caught
up with building new packages.

# apt-get dist-upgrade

>>> Read the warnings about potential packages being removed <<<

Finally, you should install the popularity-contest package to help the popularity
of the sparc64 port:

# apt-get install popularity-contest

The more people are running the sparc64 port of Debian, the easier it will be for
us to convince the release team to make sparc64 an official Debian port!

Thanks,
Adrian

> [1] http://popcon.debian.org/
> [2] https://people.debian.org/~glaubitz/debian-cd/2016-05-04/debian-9.0-sparc64-NETINST-1.iso

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
