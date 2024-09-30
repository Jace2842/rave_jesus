use_debug false
use_bpm 120

v_bat=1
v_prc=0.5
v_amb=1
v_elec=1
v_r=0.25
v_p=0
live_loop :bateria do
  sample(ring, :bd_haus,:sn_zome).tick,amp:1*v_bat
  sleep 1
end
prc=[:elec_triangle,:elec_twang,:perc_snap2,:elec_beep,:drum_cowell ]

live_loop :percusion do
  sample prc.choose,amp:1*v_prc
  sleep 1
end

live_loop :ambiente do
  sample :ambi_soft_buzz, rate:12,amp:1*v_amb
  sleep (ring, 0.5, 1.5, 1).tick
end
live_loop :elec do
  sample :elec_blip,rpitch:(ring,2,5,8,12,17).choose, amp:1*v_elec
  sleep 0.5
end

live_loop:ruido do
  sync:bateria
  with_synth :pnoise do
    play :d1, attack: 0.05, decay: 0.08, release: 0.1, amp:1*v_r,room: 0.6,damp: 0.4
  end
  use_synth:dtri
  live_loop:piano do
    use_random_seed 114
    8.times do
      play scale(64,:minor,num_octaves: 2).choose, amp:1*v_p
      sleep 2
    end
  end
  
end