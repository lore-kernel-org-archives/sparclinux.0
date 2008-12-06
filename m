From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 08:34:16 +0000
Subject: common header file in sparc/kernel/ - kernel.h?
Message-Id: <20081206083416.GA14404@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave.

A lot of sparc code uses local extern definitions of
variabels and local function prototypes.
sparse is good at reporting this.

I tried to look for the right place to add these but
did not really find it.
For sparc64 we have "entry.h" but that does not look like
a shareable file at all.

So I'm considering creating a sparc/kernel/kernel.h
for all the local definitions for this directory.

Samples:

/* from cpu.c */
extern const char *sparc_cpu_type;
extern const char *sparc_fpu_type;

extern void cpu_probe(void);
extern void clock_stop_probe(void); /* tadpole.c */
extern void sun4c_probe_memerr_reg(void);

extern void auxio_probe(void);
extern void auxio_power_probe(void);

$ grep extern *32.c | wc -l
80

	Sam
