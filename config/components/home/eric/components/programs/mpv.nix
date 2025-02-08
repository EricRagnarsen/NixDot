{
	pkgs,
	...
}: {
	programs = {
		mpv = {
			enable = true;
			config = {
				gpu-api = "vulkan";
				hwdec = "auto-copy";
				vo = "gpu-next";
				dither-depth = "auto";
				deband = true;
				deband-iterations = 4;
				deband-threshold = 35;
				deband-range = 16;
				deband-grain = 4;
				video-sync = "display-resample";
				interpolation = true;
				tscale = "sphinx";
				tscale-blur = 0.6991556596428412;
				tscale-radius = 1.05;
				tscale-clamp = 0.0;
				tone-mapping = "bt.2446a";
				target-colorspace-hint = true;
				volume-max = 200;
				audio-file-auto = "fuzzy";
				audio-pitch-correction = true;
				border = false;
				hr-seek-framedrop = false;
				msg-color = true;
				msg-module = true;
				autofit = "85%x85%";
				cursor-autohide = 300;
				osc = false;
				osd-bar = true;
				blend-subtitles = false;
				sub-ass-vsfilter-blur-compat = true;
				sub-ass-scale-with-window = false;
				sub-auto = "fuzzy";
				demuxer-mkv-subtitle-preroll = true;
				embeddedfonts = true;
				sub-fix-timing = false;
			};
			defaultProfiles = [
				"gpu-hq"
			];
			profiles = {
				"protocol.http" = {
					hls-bitrate = "max";
					cache = true;
				};
				"protocol.https" = {
					profile = "protocol.http";
				};
				"protocol.ytdl" = {
					profile = "protocol.http";
				};
			};
			scripts = with pkgs.mpvScripts; [
				autoload
				modernx
				thumbfast
				quack
				reload
			];
		};
	};
}